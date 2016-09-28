program main
   use intermed

   character (len=*),parameter :: fPath='fileIn2.cpp', fName ='f2'
   integer, parameter:: gama = 6
   integer:: i
   real(8), parameter:: a = 0.065, C = 1.168, h = 0.035, v5 = 0.0, v6 = 0.0, v7 =0.0, v8 = 0.0, v9=0.0
   real(8):: numDouble, y
   type(dyn_module) :: dmodule
   procedure(dyn_proc), pointer :: proc
   call load_module('fileIn2.cpp', dmodule)
   call load_func(dmodule,'f2', proc)

   do i = 3,10
      y = (i/100.0)
      numDouble = proc(a, C, h, gama, y)
      print *, "Retorno da funçao:    ", numDouble
   end do
end program main
