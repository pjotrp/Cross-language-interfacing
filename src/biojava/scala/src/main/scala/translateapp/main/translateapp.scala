/**
 * Called from ./DNAtranslate
 *
 */

// import bio._
// import bio.Protein._
// import bio.io.Control._
import java.io._

object TranslateApp {
  val version = "0.01"

  def main(args: Array[String]) {
    val arglist = args.toList
    if (args.length == 0) {
      println("DNAtranslate "+version)
      println("""

  Translate a FASTA nucleotide sequence file to amino acids (protein) using
  BioJava translation

  Usage:

    ./DNAtranslate [-v] infile [--times n]

  Examples:

    ./DNAtranslate ../../../test/data/test-dna.fa

      """)
      exit(1)
    }

    type OptionMap = Map[scala.Symbol, Any]
    
    def strOption(s: String) = {
      val regex = """(\d+)""".r
      s match {
        case regex(times) => Map('times -> times)
        case filename => Map('infile -> filename)
      }
    }
    def nextOption(map : OptionMap, list: List[String]) : OptionMap = {
      def switch(s : String) = (s(0) == '-')
      list match {
        case Nil => map
        case "-v" :: tail =>
                               nextOption(map ++ Map('verbose -> true), tail)
        case "--times" :: value :: tail =>
                               nextOption(map ++ Map('times -> value), tail)

        case string :: opt2 :: tail if switch(opt2) => 
                               nextOption(map ++ strOption(string), list.tail)
        case string :: Nil =>  nextOption(map ++ strOption(string), list.tail)
        case option :: tail => println("Unknown option "+option) 
                               exit(1) 
      }
      // Map('type -> false)
    }
    val options = nextOption(Map(),arglist)

    options.get( 'outfile ) match { 
      case Some(fn) => println("TranslateApp "+version)
                       println(options)
      case _ => 
    }
    def getBool(name : scala.Symbol) : Boolean = 
      options.get( name ) match {
        case Some(_) => true
        case None    => false
      }
   
    def getInt(name : scala.Symbol, default : Int) : Int = 
      options.get( name ) match {
        case Some(v) => v.toString.toInt
        case None    => default
      }
   
    val times = getInt('times,1) 
    val verbose = getBool('verbose)

    // --- read input file
    val infile = options.get( 'infile ) match { 
      case Some(v) => v.toString
      case None => throw new Exception
    }
    if (verbose) {
      println("Reading Fasta file", infile, " x ", times)

    }
    // val list = new FastaReader(infile).toList
    0
  } // main
} // object


