#!/usr/bin/julia
# Julia program
#=
    I wrote this program because the Famous Monsters Of Filmland (FMOF) PDFs
    are just images. There is no text to select or search on. So...

    This program extracts all images from the FMOF PDFs
    into a directory, one image per page, using the Linux command line program "pdfimages".
    Each PDF is an issue. It then extracts the text from those images using the Linux OCR
    command line program "tesseract".

    It would be very tedious to do this manually.

    On: 10/18/2018

    mkdir("directory")
    touch()
    rm()
    mv(src,dest) move/rename

    cd(path) changes the current directory
    readdir(path) returns a lists of the contents of a named directory, or the current directory,
    abspath(path) adds the current directory's path to a filename to make an absolute pathname
    joinpath(str, str, ...) assembles a pathname from pieces
    isdir(path) tells you whether the path is a directory
    splitdir(path) - split a path into a tuple of the directory name and file name.
    splitdrive(path) - on Windows, split a path into the drive letter part and the path part. On Unix systems, the first component is always the empty string.
    splitext(path) - if the last component of a path contains a dot, split the path into everything before the dot and everything including and after the dot. Otherwise, return a tuple of the argument unmodified and the empty string.
    expanduser(path) - replace a tilde character at the start of a path with the current user's home directory.
    normpath(path) - normalize a path, removing "." and ".." entries.
    realpath(path) - canonicalize a path by expanding symbolic links and removing "." and ".." entries.
    homedir() - current user's home directory.
    dirname(path) - get the directory part of a path.
    basename(path)- get the file name part of a path.

=#

#Int('\\')
#Char(92)

bslash=string('\\')
bslash=Char(92)

#println("Home :",homedir())

dir="/media/bill/1450FC356E30C66C/Famous Monsters Of Filmland/Disc2/"
dr=readdir(dir)  # read a direciory up from current directory
#println(dr)
println()

println("Process PDFs")
#dr=readdir()    # read current directory
fcnt=0
dcnt=0
cnt=0
#dirSw=false
for f in dr
    if endswith(f, ".pdf")
        cnt+=1
        #println(f)
        seq=f[end-6:end-4]
        if parse(Int64,seq)<191  #<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            continue
        end
        seq1=seq
        #println(seq1)
        global fcnt,dcnt,cnt
        d=dir*string(seq)*"/"
        mkdir(d)
        d1=d*"/FMOF"
        st1=dir*f
        cmd=`pdfimages -j $st1 $d1`
        #println(typeof(cmd))
        println("Extracting images from ",f," ########################")
        #println(cmd)
        run(cmd)
        dr2=readdir(d)
        for f2 in dr2
            seq=f2[end-6:end-4]
            println("Extracting text from ",f2)
            cmd=`tesseract $d$f2 $d$seq1-$seq`
            run(cmd)
        end
        """
        if cnt>1
            break
        end
        """
    end
end
println("Finished!")
