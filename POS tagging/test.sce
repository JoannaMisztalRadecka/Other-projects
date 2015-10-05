test = list()
test(1) = list("Kasia","robi","herbatę")
test(2) = list("ktoś","dzwoni")
test(3) = list("ona","ma","dzieci")
test(4) = list("Wojtek","jest","uczniem")
test(5) = list("chorzy","coś","robią")
test(6) = list("oni","są","zadowoleni")
test(7) = list("on","ma","lekcje")
test(8) = list("on","cię","lubi")
test(9) = list("Wacek","jest","uczniem")
test(10) = list("ktoś","robi","herbatę")
test(11) = list("oni","robią","coś","bez","ciebie")
test(12) = list("on","woli","pierogi")
test(13) = list("Kasia","lubi","brata")
test(14) = list("mama","ma","dużo","dzieci")
test(15) = list("Kasia","piła","wodę")
test(16) = list("piła","jest","bardzo","ostra")


parts = list()
parts(1) = list(1,3,1)
parts(2) = list(5,3)
parts(3) = list(5,3,1)
parts(4) = list(1,3,1)
parts(5) = list(1,5,3)
parts(6) = list(5,3,2)
parts(7) = list(5,3,1)
parts(8) = list(5,5,3)
parts(9) = list(1,3,1)
parts(10) = list(5,3,1)
parts(11) = list(5,3,5,7,5)
parts(12) = list(5,3,1)
parts(13) = list(1,3,1)
parts(14) = list(1,3,4,1)
parts(15) = list(1,3,1)

function err = makeTest()
    err=0
   nr=0
   for i=1:length(test)
       result = findSequence(test(i))
       nr = nr+length(test(i))
       for j=1:length(result)
           if result(j)<>parts(i)(j) then
               err=err+1
           end
       end
   end

 err = err/nr

endfunction