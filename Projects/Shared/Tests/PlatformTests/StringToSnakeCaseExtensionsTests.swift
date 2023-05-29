//
//  StringToSnakeCaseExtensionsTests.swift
//
//
//  Created by Elon on 2022/12/30.
//

import XCTest

import AppTestSupport
@testable import Platform

final class StringToSnakeCaseExtensionsTests: XCTestCase {

  func test_convert_to_snake_case() {
    // given
    let toSnakeCaseTests = [
      ("simpleOneTwo", "simple_one_two"),
      ("myURL", "my_url"),
      ("singleCharacterAtEndX", "single_character_at_end_x"),
      ("thisIsAnXMLProperty", "this_is_an_xml_property"),
      ("single", "single"), // no underscore
      ("", ""), // don't die on empty string
      ("a", "a"), // single character
      ("aA", "a_a"), // two characters
      ("version4Thing", "version4_thing"), // numerics
      ("partCAPS", "part_caps"), // only insert underscore before first all caps
      ("partCAPSLowerAGAIN", "part_caps_lower_again"), // switch back and forth caps.
      ("manyWordsInThisThing", "many_words_in_this_thing"), // simple lowercase + underscore + more
      ("asdfĆqer", "asdf_ćqer"),
      ("already_snake_case", "already_snake_case"),
      ("dataPoint22", "data_point22"),
      ("dataPoint22Word", "data_point22_word"),
      ("_oneTwoThree", "_one_two_three"),
      ("oneTwoThree_", "one_two_three_"),
      ("__oneTwoThree", "__one_two_three"),
      ("oneTwoThree__", "one_two_three__"),
      ("_oneTwoThree_", "_one_two_three_"),
      ("__oneTwoThree", "__one_two_three"),
      ("__oneTwoThree__", "__one_two_three__"),
      ("_test", "_test"),
      ("_test_", "_test_"),
      ("__test", "__test"),
      ("test__", "test__"),
      ("m͉̟̹y̦̳G͍͚͎̳r̤͉̤͕ͅea̲͕t͇̥̼͖U͇̝̠R͙̻̥͓̣L̥̖͎͓̪̫ͅR̩͖̩eq͈͓u̞e̱s̙t̤̺ͅ", "m͉̟̹y̦̳_g͍͚͎̳r̤͉̤͕ͅea̲͕t͇̥̼͖_u͇̝̠r͙̻̥͓̣l̥̖͎͓̪̫ͅ_r̩͖̩eq͈͓u̞e̱s̙t̤̺ͅ"), // because Itai wanted to test this
      ("🐧🐟", "🐧🐟"), // fishy emoji example?
    ]

    // when
    for test in toSnakeCaseTests {
      let expected = test.0.toSnakeCase

      // then
      XCTAssertEqual(expected, test.1)
    }
  }
}
