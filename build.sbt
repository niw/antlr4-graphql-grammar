scalaVersion := "2.13.4"
scalacOptions += "-deprecation"

enablePlugins(Antlr4Plugin)

antlr4Version in Antlr4 := "4.9"
antlr4GenListener in Antlr4 := false
antlr4GenVisitor in Antlr4 := false
antlr4TreatWarningsAsErrors in Antlr4 := true

antlr4PackageName in Antlr4 := Some("graphql")

libraryDependencies += "com.fasterxml.jackson.module" %% "jackson-module-scala" % "2.12.0"
libraryDependencies += "com.fasterxml.jackson.dataformat" % "jackson-dataformat-yaml" % "2.12.0"
libraryDependencies += "org.scalatest" %% "scalatest" % "3.2.2" % "test"
