//
// Pluralize.swift
// link:
//     https://github.com/joshualat/Pluralize.swift
//
// usage:
//     "Tooth".pluralize
//     "Nutrtion".pluralize
//     "House".pluralize(count: 1)
//     "Person".pluralize(count: 2, with: "Persons")
//
// Copyright (c) 2014 Joshua Arvin Lat
//
// MIT License
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Foundation

public class Pluralize {
    var uncountables:[String] = []
    var rules:[(rule: String, template: String)] = []

    public init() {
        uncountables = [
            "access", "accommodation", "adulthood", "advertising", "advice",
            "aggression", "aid", "air", "alcohol", "anger", "applause",
            "arithmetic", "art", "assistance", "athletics", "attention",
            "bacon", "baggage", "ballet", "beauty", "beef", "beer", "biology",
            "botany", "bread", "butter", "carbon", "cash", "chaos", "cheese",
            "chess", "childhood", "clothing", "coal", "coffee", "commerce",
            "compassion", "comprehension", "content", "corruption", "cotton",
            "courage", "currency", "dancing", "danger", "data", "delight",
            "dignity", "dirt", "distribution", "dust", "economics", "education",
            "electricity", "employment", "engineering", "envy", "equipment",
            "ethics", "evidence", "evolution", "faith", "fame", "fish", "flour", "flu",
            "food", "freedom", "fuel", "fun", "furniture", "garbage", "garlic",
            "genetics", "gold", "golf", "gossip", "grammar", "gratitude", "grief",
            "ground", "guilt", "gymnastics", "hair", "happiness", "hardware",
            "harm", "hate", "hatred", "health", "heat", "height", "help", "homework",
            "honesty", "honey", "hospitality", "housework", "humour", "hunger",
            "hydrogen", "ice", "ice", "cream", "importance", "inflation", "information",
            "injustice", "innocence", "iron", "irony", "jealousy", "jelly", "judo",
            "karate", "kindness", "knowledge", "labour", "lack", "laughter", "lava",
            "leather", "leisure", "lightning", "linguistics", "litter", "livestock",
            "logic", "loneliness", "luck", "luggage", "machinery", "magic",
            "management", "mankind", "marble", "mathematics", "mayonnaise",
            "measles", "meat", "methane", "milk", "money", "mud", "music", "nature",
            "news", "nitrogen", "nonsense", "nurture", "nutrition", "obedience",
            "obesity", "oil", "oxygen", "passion", "pasta", "patience", "permission",
            "physics", "poetry", "pollution", "poverty", "power", "pronunciation",
            "psychology", "publicity", "quartz", "racism", "rain", "relaxation",
            "reliability", "research", "respect", "revenge", "rice", "rubbish",
            "rum", "salad", "satire", "seaside", "shame", "shopping", "silence",
            "sleep", "smoke", "smoking", "snow", "soap", "software", "soil",
            "sorrow", "soup", "speed", "spelling", "steam", "stuff", "stupidity",
            "sunshine", "symmetry", "tennis", "thirst", "thunder", "toast",
            "tolerance", "toys", "traffic", "transporation", "travel", "trust", "understanding",
            "unemployment", "unity", "validity", "veal", "vengeance", "violence"]

        rule("$", with:"$1s")
        rule("s$", with:"$1ses")
        rule("(r|l|b)y$", with:"$1ies")
        rule("x$", with:"$1xes")
        rule("(sh|zz|ss)$", with:"$1es")
        rule("(ax)is", with: "$1es")
        rule("(cact|nucle|alumn|bacill|fung|radi|stimul|syllab)us$", with:"$1i")
        rule("(corp)us$", with:"$1ora")
        rule("sis$", with:"$1ses")
        rule("ch$", with:"$1ches")
        rule("o$", with:"$1os")
        rule("(buffal|carg|mosquit|torped|zer|vet|her|ech)o$", with:"$1oes")
        rule("fe$", with:"$1ves")
        rule("(thie)f$", with:"$1ves")
        rule("oaf$", with:"$1oaves")
        rule("um$", with:"$1a")
        rule("ium$", with:"$1ia")
        rule("oof$", with:"$1ooves")
        rule("(nebul)a", with:"$1ae")
        rule("(criteri|phenomen)on$", with:"$1a")
        rule("(potat|tomat|volcan)o$", with:"$1oes")
        rule("^(|wo|work|fire)man$", with: "$1men")
        rule("(f)oot$", with: "$1eet")
        rule("lf$", with: "$1lves")
        rule("(t)ooth$", with: "$1eeth")
        rule("(g)oose$", with: "$1eese")
        rule("^(c)hild$", with: "$1hildren")
        rule("^(o)x$", with: "$1xen")
        rule("^(p)erson$", with: "$1eople")
        rule("(m|l)ouse$", with: "$1ice")
        rule("^(d)ie$", with: "$1ice")
        rule("^(alg|vertebr|vit)a$", with: "$1ae")
        rule("^(a)lumna$", with: "$1lumnae")
        rule("^(a)pparatus$", with: "$1pparatuses")
        rule("^(ind)ex$", with: "$1ices")
        rule("^(append|matr)ix$", with: "$1ices")
        rule("^(b|tabl)eau$", with: "$1eaux")
        rule("arf$", with: "$1arves")
        rule("(embarg)o$", with: "$1oes")
        rule("(gen)us$", with: "$1era")
        rule("(r)oof$", with: "$1oofs")
        rule("(l)eaf$", with: "$1eaves")
        rule("(millen)ium$", with: "$1ia")
        rule("(th)at$", with: "$1ose")
        rule("(th)is$", with: "$1ese")

        unchanging("sheep")
        unchanging("deer")
        unchanging("moose")
        unchanging("swine")
        unchanging("bison")
        unchanging("corps")
        unchanging("means")
        unchanging("series")
        unchanging("scissors")
        unchanging("species")
    }

    public class func apply(word: String) -> String {
        if sharedInstance.uncountables.contains(word.lowercaseString) || word.characters.count == 0 {
            return word
        } else {
            for pair in sharedInstance.rules {
                let newValue = regexReplace(word, pattern: pair.rule, template: pair.template)
                if newValue != word {
                    return newValue
                }
            }
        }

        return word
    }

    public class func rule(rule: String, with template: String) {
        sharedInstance.rule(rule, with: template)
    }

    public class func uncountable(word: String) {
        sharedInstance.uncountable(word)
    }

    public class func unchanging(word: String) {
        sharedInstance.unchanging(word)
    }

    public class var sharedInstance : Pluralize {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : Pluralize? = nil
        }

        dispatch_once(&Static.onceToken) {
            Static.instance = Pluralize()
        }

        return Static.instance!
    }

    private class func regexReplace(input: String, pattern: String, template: String) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
        let range = NSMakeRange(0, input.characters.count)
        let output = regex.stringByReplacingMatchesInString(input, options: [], range: range, withTemplate: template)
        return output
    }

    private func rule(rule: String, with template: String) {
        rules.insert((rule: rule, template: template), atIndex: 0)
    }

    private func uncountable(word: String) {
        uncountables.insert(word.lowercaseString, atIndex: 0)
    }

    private func unchanging(word: String) {
        uncountables.insert(word.lowercaseString, atIndex: 0)
    }
}

extension String {
    public func pluralize(num: Int = 2, with: String = "") -> String {
        if num == 1 {
            return self
        } else {
            if with.characters.count != 0 {
                return with
            } else {
                return Pluralize.apply(self)
            }
        }
    }
}

