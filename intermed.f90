module intermed
use, intrinsic :: iso_c_binding

implicit none

interface
        subroutine c_load_module(fPath, ctx) bind(c, name='load_module')
                use, intrinsic :: iso_c_binding
                character(kind=c_char) :: fPath(*)
                type(c_ptr) :: ctx
        end subroutine c_load_module

        subroutine c_load_func(ctx, fName, func) bind(C, name="load_func")
                use, intrinsic :: iso_c_binding
                type(c_ptr) :: ctx
                character(kind=c_char) :: fName(*)
                type(c_funptr) :: func
        end subroutine c_load_func

        function dyn_proc(a, c, h, gama, y)
                use, intrinsic :: iso_c_binding
                real(c_double) :: dyn_proc, a, c, h, y
                integer(c_int) :: gama
        end function
end interface

type dyn_module
        type(c_ptr) :: c_ctx
end type dyn_module

contains

subroutine load_module(fPath, dmodule)
        character(len=*) :: fPath
        type(dyn_module) :: dmodule
        character(kind=c_char, len=len(fPath)+1) :: c_str

        c_str = fPath // c_null_char
        call c_load_module(c_str, dmodule%c_ctx)
end subroutine load_module

subroutine load_func(dmodule, fName, proc)
        type(dyn_module) :: dmodule
        character(len=*) :: fName
        procedure(dyn_proc), pointer :: proc
        type(c_funptr) :: c_func
        character(kind=c_char, len=len(fName)+1) :: c_str

        c_str = fName // c_null_char
        call c_load_func(dmodule%c_ctx, c_str, c_func)
        call c_f_procpointer(c_func, proc)
end subroutine load_func

end module intermed

