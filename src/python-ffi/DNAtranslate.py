from ctypes import *
import os

emboss = cdll.LoadLibrary(os.path.join(os.path.dirname(os.path.abspath(__file__)),"emboss.so"))

trnTable = emboss.ajTrnNewI(1)
ajpseq   = emboss.ajSeqNewNameC(b"atgtcaatggtaagaaatgtatcaaatcagagcgaaaaattggaaattttgt", b"Test sequence")
ajpseqt  = emboss.ajTrnSeqOrig(trnTable,ajpseq,1)

seq = emboss.ajSeqGetSeqCopyC(ajpseqt)
seq = str(c_char_p(seq).value,'utf-8')
print(seq)