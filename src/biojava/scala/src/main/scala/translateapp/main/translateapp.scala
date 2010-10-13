/**
 * Called from ./DNAtranslate
 *
 */

import bio._
import bio.Protein._
import java.io._
import org.biojava.bio.symbol._
import org.biojava.bio.seq._

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

    ./DNAtranslate [-v] [--skip-translate] infile [--times n]

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
        case "--skip-translate" :: tail =>
                               nextOption(map ++ Map('skipTranslate -> true), tail)
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
    val skipTranslate = getBool('skipTranslate)

    // --- read input file
    val infile = options.get( 'infile ) match { 
      case Some(v) => v.toString
      case None => throw new Exception
    }
    if (verbose) {
      println("Reading Fasta file", infile, " x ", times)

    }
    val f = new FastaReader(infile)
      val ids = f.foreach { 
        res => 
          val (id,tag,dna) = res
          println((">",id).toString) 
          if (skipTranslate) {
            println(dna)
          }
          else {
            val s = new CodonSequence(dna)
            println(s)
          }
        }

    0
  } // main
} // object


