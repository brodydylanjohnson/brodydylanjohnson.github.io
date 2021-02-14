      program indexer
      integer i,nalb,npg
      character fname*12,pn*2,an*2,cap1*60,cap2*60,name*12

   1  write(*,*) 'Album Number: '
      read(*,*) nalb
      if ((nalb.lt.0) .or. (nalb.ge.100)) goto 1

   2  write(*,*) 'Number of Pages: (1<=pages<=99)'
      read(*,*) npg
      if ((npg.le.0) .or. (npg.ge.100)) goto 2

      an = char((nalb-mod(nalb,10))/10+48) //
     $     char(mod(nalb,10)+48)
      name = 'album' // an // '.txt'
      open(5,file=name,status='old')

      fname = 'alb' // an // 'toc' // '.htm'
      open(4,file=fname,status='new')

C  WRITING HTM FILE FOR ALBUM INDEX
      write(4,*) '<html>'
      write(4,*) '<head>'
      write(4,*) '<title>Table of Contents</title>'
      write(4,*) '<link rel="stylesheet" type="text/css"',
     $           ' href="../htmlfiles/album.css" />'
      write(4,*) '<script src="../htmlfiles/hotchocolate.js"> </script>'
      write(4,*) '</head>'
      write(4,*) '<body>'
      write(4,*) '<table class="covernav">'
      write(4,*) '<tr><td class="middle">'
      write(4,*) '<a class="bj" href="./index.html"> <h1>',
     $           'Cover </h1> </a>'
      write(4,*) '</td></tr>'
      write(4,*) '</table>'
      write(4,*) '<table class="toc">'
      write(4,*) '<tr><td colspan="2" align="center"> <h2>',
     $           ' Table of Contents'
      write(4,*) '</h2><br></td></tr>'
      write(4,*) '<tr><td class="num">'
      write(4,*) '<u>Photo Number</u>'
      write(4,*) '</td><td class="cap">'
      write(4,*) '<u>Photo Caption</u>'
      write(4,*) '</td></tr>'

      do 51 i=1,npg
        pn = char((i-mod(i,10))/10+48) //
     $       char(mod(i,10)+48)
        fname = 'alb' // an // pn // '.htm'
        read(5,*)
        read(5,*)
        read(5,*) cap1
        write(4,*) '<tr><td class="num">'
        write(4,*) '<a class="bj" href="./',fname,'">'
        write(4,*) char((i-mod(i,10))/10+48) //
     $             char(mod(i,10)+48) // '(a) </a>'
        write(4,*) '</td><td class="cap">'
        write(4,*) cap1
        write(4,*) '</td></tr>'

        read(5,*)
        read(5,*)
        read(5,*) cap2
        write(4,*) '<tr><td class="num">'
        write(4,*) '<a class="bj" href="./',fname,'">'
        write(4,*) char((i-mod(i,10))/10+48) //
     $             char(mod(i,10)+48) // '(b) </a>'
        write(4,*) '</td><td class="cap">'
        write(4,*) cap2
        write(4,*) '</td></tr>'
 51   continue

      write(4,*) '</table>'
      write(4,*) '</body>'
      write(4,*) '</html>'
      close(4)
      close(5)
      end
