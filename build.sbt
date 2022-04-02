scalaVersion := "2.13.8"
scalacOptions += "-deprecation"

enablePlugins(Antlr4Plugin)

Antlr4 / antlr4Version := "4.9.3"
Antlr4 / antlr4GenListener := false
Antlr4 / antlr4GenVisitor := false
Antlr4 / antlr4TreatWarningsAsErrors := true

Antlr4 / antlr4PackageName := Some("graphql")

libraryDependencies += "com.fasterxml.jackson.module" %% "jackson-module-scala" % "2.12.0"
libraryDependencies += "com.fasterxml.jackson.dataformat" % "jackson-dataformat-yaml" % "2.12.0"
libraryDependencies += "org.scalatest" %% "scalatest" % "3.2.2" % "test"
