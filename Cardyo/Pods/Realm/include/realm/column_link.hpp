/*************************************************************************
 *
 * REALM CONFIDENTIAL
 * __________________
 *
 *  [2011] - [2012] Realm Inc
 *  All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains
 * the property of Realm Incorporated and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Realm Incorporated
 * and its suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Realm Incorporated.
 *
 **************************************************************************/
#ifndef REALM_COLUMN_LINK_HPP
#define REALM_COLUMN_LINK_HPP

#include <realm/column.hpp>
#include <realm/column_linkbase.hpp>
#include <realm/column_backlink.hpp>

namespace realm {

/// A link column is an extension of an integer column (Column) and maintains
/// its node structure.
///
/// The individual values in a link column are indexes of rows in the target
/// table (offset with one to allow zero to indicate null links.) The target
/// table is specified by the table descriptor.
class LinkColumn: public LinkColumnBase {
public:
    using LinkColumnBase::LinkColumnBase;
    ~LinkColumn() noexcept override;

    static ref_type create(Allocator&, std::size_t size = 0);

    bool is_nullable() const noexcept override;

    //@{

    /// is_null_link() is shorthand for `get_link() == realm::npos`,
    /// nullify_link() is shorthand foe `set_link(realm::npos)`, and
    /// insert_null_link() is shorthand for
    /// `insert_link(realm::npos)`. set_link() returns the original link, with
    /// `realm::npos` indicating that it was null.

    std::size_t get_link(std::size_t row_ndx) const noexcept;
    bool is_null(std::size_t row_ndx) const noexcept override;
    bool is_null_link(std::size_t row_ndx) const noexcept;
    std::size_t set_link(std::size_t row_ndx, std::size_t target_row_ndx);
    void set_null(std::size_t row_ndx) override;
    void nullify_link(std::size_t row_ndx);
    void insert_link(std::size_t row_ndx, std::size_t target_row_ndx);
    void insert_null_link(std::size_t row_ndx);

    //@}

    void insert_rows(size_t, size_t, size_t) override;
    void erase_rows(size_t, size_t, size_t, bool) override;
    void move_last_row_over(size_t, size_t, bool) override;
    void clear(std::size_t, bool) override;
    void cascade_break_backlinks_to(std::size_t, CascadeState&) override;
    void cascade_break_backlinks_to_all_rows(std::size_t, CascadeState&) override;

#ifdef REALM_DEBUG
    void verify(const Table&, std::size_t) const override;
#endif

protected:
    friend class BacklinkColumn;
    void do_nullify_link(std::size_t row_ndx, std::size_t old_target_row_ndx) override;
    void do_update_link(std::size_t row_ndx, std::size_t old_target_row_ndx,
                        std::size_t new_target_row_ndx) override;

private:
    void remove_backlinks(std::size_t row_ndx);
};


// Implementation

inline LinkColumn::~LinkColumn() noexcept
{
}

inline bool LinkColumn::is_nullable() const noexcept
{
    return true;
}

inline ref_type LinkColumn::create(Allocator& alloc, std::size_t size)
{
    return IntegerColumn::create(alloc, Array::type_Normal, size); // Throws
}

inline bool LinkColumn::is_null(std::size_t row_ndx) const noexcept
{
    // Null is represented by zero
    return LinkColumnBase::get(row_ndx) == 0;
}

inline std::size_t LinkColumn::get_link(std::size_t row_ndx) const noexcept
{
    // Map zero to realm::npos, and `n+1` to `n`, where `n` is a target row index.
    return to_size_t(LinkColumnBase::get(row_ndx)) - size_t(1);
}

inline bool LinkColumn::is_null_link(std::size_t row_ndx) const noexcept
{
    return is_null(row_ndx);
}

inline std::size_t LinkColumn::set_link(std::size_t row_ndx, std::size_t target_row_ndx)
{
    int_fast64_t old_value = LinkColumnBase::get(row_ndx);
    std::size_t old_target_row_ndx = to_size_t(old_value) - size_t(1);
    if (old_value != 0)
        m_backlink_column->remove_one_backlink(old_target_row_ndx, row_ndx); // Throws

    int_fast64_t new_value = int_fast64_t(size_t(1) + target_row_ndx);
    LinkColumnBase::set(row_ndx, new_value); // Throws

    if (target_row_ndx != realm::npos)
        m_backlink_column->add_backlink(target_row_ndx, row_ndx); // Throws

    return old_target_row_ndx;
}

inline void LinkColumn::set_null(size_t row_ndx)
{
    set_link(row_ndx, realm::npos); // Throws
}

inline void LinkColumn::nullify_link(size_t row_ndx)
{
    set_null(row_ndx); // Throws
}

inline void LinkColumn::insert_link(std::size_t row_ndx, std::size_t target_row_ndx)
{
    int_fast64_t value = int_fast64_t(size_t(1) + target_row_ndx);
    LinkColumnBase::insert(row_ndx, value); // Throws

    if (target_row_ndx != realm::npos)
        m_backlink_column->add_backlink(target_row_ndx, row_ndx); // Throws
}

inline void LinkColumn::insert_null_link(size_t row_ndx)
{
    insert_link(row_ndx, realm::npos); // Throws
}

inline void LinkColumn::do_update_link(std::size_t row_ndx, std::size_t,
                                       std::size_t new_target_row_ndx)
{
    // Row pos is offset by one, to allow null refs
    LinkColumnBase::set(row_ndx, new_target_row_ndx + 1);
}

} //namespace realm

#endif //REALM_COLUMN_LINK_HPP
