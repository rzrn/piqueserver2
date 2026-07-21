from libc.math cimport NAN

DEF INT_ERROR = -0xFFFFFFFF >> 1
DEF LONG_LONG_ERROR = -0xFFFFFFFFFFFFFFFF >> 1

cdef extern from "<sstream>" namespace "std":
    cdef cppclass stringstream:
        pass

cdef class ByteReader:
    cdef char * data
    cdef char * pos
    cdef char * end
    cdef int start, size
    cdef object input

    cdef char * check_available(self, int size) except NULL
    cpdef read(self, int bytecount = ?)

    cpdef int readInt8LE(self) except INT_ERROR
    cpdef int readUInt8LE(self) except INT_ERROR

    cpdef int readInt16LE(self) except INT_ERROR
    cpdef int readUInt16LE(self) except INT_ERROR

    cpdef long long readInt32LE(self) except LONG_LONG_ERROR
    cpdef long long readUInt32LE(self) except LONG_LONG_ERROR

    cpdef float readFloat32LE(self) except? NAN

    cpdef int readChar(self)
    cpdef bytes readString(self, int size = ?)

    cpdef ByteReader readReader(self, int size = ?)
    cpdef int dataLeft(self)
    cdef void _skip(self, int bytecount)
    cpdef skipBytes(self, int bytecount)
    cpdef rewind(self, int value)
    cpdef seek(self, size_t pos)
    cpdef size_t tell(self)

cdef class ByteWriter:
    cdef stringstream * stream

    cdef void writeSize(self, char * data, int size)
    cpdef write(self, data)

    cpdef writeInt8LE(self, int value)
    cpdef writeUInt8LE(self, int value)

    cpdef writeInt16LE(self, int value)
    cpdef writeUInt16LE(self, int value)

    cpdef writeInt32LE(self, int value)
    cpdef writeUInt32LE(self, int value)

    cpdef writeFloat32LE(self, float value)

    cpdef writeChar(self, value)
    cpdef writeString(self, value, int size = ?)
    cpdef writeStringSize(self, char * value, int size)

    cpdef pad(self, int bytecount)
    cpdef rewind(self, int bytecount)
    cpdef size_t tell(self)
