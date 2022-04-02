package graphqlcats

import com.fasterxml.jackson.annotation.JsonProperty
import com.fasterxml.jackson.databind.{
  DeserializationFeature,
  ObjectMapper,
  PropertyNamingStrategies
}
import com.fasterxml.jackson.dataformat.yaml.YAMLFactory
import com.fasterxml.jackson.module.scala.{DefaultScalaModule, ScalaObjectMapper}

import java.net.URL

// Partial GraphQL Compatibility Acceptance Tests (graphql-cats) YAML representation
// that is enough for schema parser scenarios.
// See <https://github.com/graphql-cats/graphql-cats#scenario-file-format> for the YAML format details.

object Scenario {
  private def mapper =
    (new ObjectMapper(new YAMLFactory()) with ScalaObjectMapper)
      .registerModule(DefaultScalaModule)
      // Ignore any fields that is not used for schema parser scenarios such as `test-data`.
      .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)
      .configure(DeserializationFeature.ACCEPT_SINGLE_VALUE_AS_ARRAY, true)
      .setPropertyNamingStrategy(PropertyNamingStrategies.LOWER_CAMEL_CASE)

  def load(url: URL): Scenario =
    mapper.readValue(url.openStream(), classOf[Scenario])
}

case class Scenario(
  scenario: String,
  background: Option[Background],
  tests: Seq[Test]
)

sealed trait Schema {
  val schema: Option[String]
  val schemaFile: Option[String]
}

case class Background(
  schema: Option[String],
  @JsonProperty("schema-file") schemaFile: Option[String]
) extends Schema

case class Test(
  name: String,
  `given`: Given,
  when: When,
  `then`: Seq[Then]
)

case class Given(
  query: String,
  schema: Option[String],
  @JsonProperty("schema-file") schemaFile: Option[String]
) extends Schema

case class When(
  parse: Option[Boolean]
)

case class Then(
  passes: Option[Boolean],
  @JsonProperty("syntax-error") syntaxError: Option[Boolean]
)
