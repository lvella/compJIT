program main
   use intermed
   use, intrinsic:: iso_c_binding, only: c_char, c_int, c_double
   character (kind=c_char, len=*),parameter :: fPath='fileIn2.cpp', fName ='f2'
   integer(c_int), parameter:: gama = 6 
   integer(c_int):: i
   real(c_double), parameter:: a = 0.065, C = 1.168, h = 0.035, v5 = 0.0, v6 = 0.0, v7 =0.0, v8 = 0.0, v9=0.0
   real(c_double):: numDouble, y
   do i = 3,10
      y = (i/100.0)
      call cfunc(fPath,len(fPath),fName, numDouble, a, C, h, y, v5, v6, v7, v8, v9, gama)
      print *, "Retorno da funçao:    ", numDouble
   end do
end program main
