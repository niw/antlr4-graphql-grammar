package graphql

import graphqlcats.{Scenario, Test, Then}
import org.antlr.v4.runtime._
import org.scalatest.funsuite.AnyFunSuite
import org.scalatest.matchers.should.Matchers

import java.io.ByteArrayInputStream

class GraphQLParserTest extends AnyFunSuite with Matchers {
  private def loadParserTests(path: String): Unit = {
    val url = getClass.getResource(path)

    val scenario = Scenario.load(url)

    def runTest(test: Test): Unit = {
      val inputStream = new ByteArrayInputStream(test.`given`.query.getBytes)

      // If the test contains any `then` that has `passes: false` or `syntaxError: true`
      // then the test should fail.
      val shouldFail = test.`then`.exists {
        case Then(Some(passes), None) => !passes
        case Then(None, Some(syntaxError)) => syntaxError
        case _ =>
          println(test.`then`)
          throw new RuntimeException(s"Invalid then in test: ${test.name}")
      }

      val charStream = CharStreams.fromStream(inputStream)
      val lexer = new GraphQLLexer(charStream) {
        // Bail out any lexer exceptions
        override def recover(e: LexerNoViableAltException): Unit =
          throw new RuntimeException(e)
      }
      val tokenStream = new CommonTokenStream(lexer)
      val parser = new GraphQLParser(tokenStream)
      // Bail out any parser exceptions
      parser.setErrorHandler(new BailErrorStrategy)
      // Remove default error listener that reports error to stderr.
      parser.removeErrorListeners()

      def parse(): Unit = parser.document

      if (shouldFail) {
        a[Exception] shouldBe thrownBy {
          parse()
        }
      } else {
        noException shouldBe thrownBy {
          parse()
        }
      }
    }

    scenario.tests.foreach { testCase =>
      test(testCase.name) {
        runTest(testCase)
      }
    }
  }

  loadParserTests("/graphql-cats/scenarios/parsing/SchemaParser.yaml")
}
