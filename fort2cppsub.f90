module fmain2cppsub
INTERFACE
        subroutine cfunc(fPath, lenPath, fName, numDouble, a, C, h,y, v5, v6, v7, v8, v9, gama) BIND(C, NAME="cfunc")
        use, intrinsic :: iso_c_binding, only: C_CHAR, C_DOUBLE, C_INT
        character(C_CHAR) :: fPath(*), fName(*)
        integer(C_INT) :: lenPath, gama 
	real(c_double) :: numDouble, a, C, h, y, v5, v6, v7, v8, v9
	end subroutine cfunc
END INTERFACE
end module fmain2cppsub

