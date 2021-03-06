###################
###  WARNING!!! ###
###################
# This file has been autogenerated

# Cython imports
from libcpp.set cimport set as cpp_set
from libcpp.vector cimport vector as cpp_vector
from cython.operator cimport dereference as deref
from cython.operator cimport preincrement as inc
from libc.stdlib cimport malloc, free
from libc.string cimport memcpy
from libcpp.string cimport string as std_string
from libcpp.utility cimport pair
from libcpp.map cimport map as cpp_map
from libcpp.vector cimport vector as cpp_vector
from cpython.version cimport PY_MAJOR_VERSION
from cpython.ref cimport PyTypeObject
from cpython.type cimport PyType_Ready
from cpython.object cimport Py_LT, Py_LE, Py_EQ, Py_NE, Py_GT, Py_GE

# Python Imports
import collections

cimport numpy as np
import numpy as np

np.import_array()

cimport xdress_extra_types

# Cython Imports For Types
cimport xdress_extra_types
from libcpp.string cimport string as std_string

# Imports For Types


dtypes = {}

if PY_MAJOR_VERSION >= 3:
    basestring = str


# Dirty ifdef, else, else preprocessor hack
# see http://comments.gmane.org/gmane.comp.python.cython.user/4080
cdef extern from *:
    cdef void emit_ifpy2k "#if PY_MAJOR_VERSION == 2 //" ()
    cdef void emit_ifpy3k "#if PY_MAJOR_VERSION == 3 //" ()
    cdef void emit_else "#else //" ()
    cdef void emit_endif "#endif //" ()

# std_string dtype
cdef MemoryKnight[std_string] mk_str = MemoryKnight[std_string]()
cdef MemoryKnight[PyXDStr_Type] mk_str_type = MemoryKnight[PyXDStr_Type]()

cdef object pyxd_str_getitem(void * data, void * arr):


    pyval = bytes(<char *> deref(<std_string *> data).c_str()).decode()
    return pyval

cdef int pyxd_str_setitem(object value, void * data, void * arr):
    cdef std_string * new_data
    cdef char * value_proxy
    if isinstance(value, basestring):
        value_bytes = value.encode()
        new_data = mk_str.renew(data)
        new_data[0] = std_string(<char *> value_bytes)
        return 0
    else:
        return -1

cdef void pyxd_str_copyswapn(void * dest, np.npy_intp dstride, void * src, np.npy_intp sstride, np.npy_intp n, int swap, void * arr):
    cdef np.npy_intp i
    cdef char * a 
    cdef char * b 
    cdef char c = 0
    cdef int j
    cdef int m
    cdef std_string * new_dest

    if src != NULL:
        if (sstride == sizeof(std_string) and dstride == sizeof(std_string)):
            new_dest = mk_str.renew(dest)
            new_dest[0] = deref(<std_string *> src)
        else:
            a = <char *> dest
            b = <char *> src
            for i in range(n):
                new_dest = mk_str.renew(<void *> a)
                new_dest[0] = deref(<std_string *> b)
                a += dstride
                b += sstride
    if swap: 
        m = sizeof(std_string) / 2
        a = <char *> dest
        for i in range(n, 0, -1):
            b = a + (sizeof(std_string) - 1);
            for j in range(m):
                c = a[0]
                a[0] = b[0]
                a += 1
                b[0] = c
                b -= 1
            a += dstride - m

cdef void pyxd_str_copyswap(void * dest, void * src, int swap, void * arr):
    cdef char * a 
    cdef char * b 
    cdef char c = 0
    cdef int j
    cdef int m
    cdef std_string * new_dest
    if src != NULL:
        new_dest = mk_str.renew(dest)
        new_dest[0] = (<std_string *> src)[0]
    if swap:
        m = sizeof(std_string) / 2
        a = <char *> dest
        b = a + (sizeof(std_string) - 1);
        for j in range(m):
            c = a[0]
            a[0] = b[0]
            a += 1
            b[0] = c
            b -= 1

cdef np.npy_bool pyxd_str_nonzero(void * data, void * arr):
    return (data != NULL)
    # FIXME comparisons not defined for arbitrary types
    #cdef std_string zero = std_string()
    #return ((<std_string *> data)[0] != zero)

cdef int pyxd_str_compare(const void * d1, const void * d2, void * arr):
    return (d1 == d2) - 1
    # FIXME comparisons not defined for arbitrary types
    #if deref(<std_string *> d1) == deref(<std_string *> d2):
    #    return 0
    #else:
    #    return -1

cdef PyArray_ArrFuncs PyXD_Str_ArrFuncs 
PyArray_InitArrFuncs(&PyXD_Str_ArrFuncs)
PyXD_Str_ArrFuncs.getitem = <PyArray_GetItemFunc *> (&pyxd_str_getitem)
PyXD_Str_ArrFuncs.setitem = <PyArray_SetItemFunc *> (&pyxd_str_setitem)
PyXD_Str_ArrFuncs.copyswapn = <PyArray_CopySwapNFunc *> (&pyxd_str_copyswapn)
PyXD_Str_ArrFuncs.copyswap = <PyArray_CopySwapFunc *> (&pyxd_str_copyswap)
PyXD_Str_ArrFuncs.nonzero = <PyArray_NonzeroFunc *> (&pyxd_str_nonzero)
PyXD_Str_ArrFuncs.compare = <PyArray_CompareFunc *> (&pyxd_str_compare)

cdef object pyxd_str_type_alloc(PyTypeObject * self, Py_ssize_t nitems):
    cdef PyXDStr_Type * cval
    cdef object pyval
    cval = mk_str_type.defnew()
    cval.ob_typ = self
    pyval = <object> cval
    return pyval

cdef void pyxd_str_type_dealloc(object self):
    cdef PyXDStr_Type * cself = <PyXDStr_Type *> self
    mk_str_type.deall(cself)
    return

cdef object pyxd_str_type_new(PyTypeObject * subtype, object args, object kwds):
    return pyxd_str_type_alloc(subtype, 0)

cdef void pyxd_str_type_free(void * self):
    return

cdef object pyxd_str_type_str(object self):
    cdef PyXDStr_Type * cself = <PyXDStr_Type *> self


    pyval = bytes(<char *> (cself.obval).c_str()).decode()
    s = str(pyval)
    return s

cdef object pyxd_str_type_repr(object self):
    cdef PyXDStr_Type * cself = <PyXDStr_Type *> self


    pyval = bytes(<char *> (cself.obval).c_str()).decode()
    s = repr(pyval)
    return s

cdef int pyxd_str_type_compare(object a, object b):
    return (a is b) - 1
    # FIXME comparisons not defined for arbitrary types
    #cdef PyXDStr_Type * x
    #cdef PyXDStr_Type * y
    #if type(a) is not type(b):
    #    raise NotImplementedError
    #x = <PyXDStr_Type *> a
    #y = <PyXDStr_Type *> b
    #if (x.obval == y.obval):
    #    return 0
    #elif (x.obval < y.obval):
    #    return -1
    #elif (x.obval > y.obval):
    #    return 1
    #else:
    #    raise NotImplementedError

cdef object pyxd_str_type_richcompare(object a, object b, int op):
    if op == Py_EQ:
        return (a is b)
    elif op == Py_NE:
        return (a is not b)
    else:
        return NotImplemented
    # FIXME comparisons not defined for arbitrary types
    #cdef PyXDStr_Type * x
    #cdef PyXDStr_Type * y
    #if type(a) is not type(b):
    #    return NotImplemented
    #x = <PyXDStr_Type *> a
    #y = <PyXDStr_Type *> b
    #if op == Py_LT:
    #    return (x.obval < y.obval)
    #elif op == Py_LE:
    #    return (x.obval <= y.obval)
    #elif op == Py_EQ:
    #    return (x.obval == y.obval)
    #elif op == Py_NE:
    #    return (x.obval != y.obval)
    #elif op == Py_GT:
    #    return (x.obval > y.obval)
    #elif op == Py_GE:
    #    return (x.obval >= y.obval)
    #else:
    #    return NotImplemented    

cdef long pyxd_str_type_hash(object self):
    return id(self)

cdef PyMemberDef pyxd_str_type_members[1]
pyxd_str_type_members[0] = PyMemberDef(NULL, 0, 0, 0, NULL)

cdef PyGetSetDef pyxd_str_type_getset[1]
pyxd_str_type_getset[0] = PyGetSetDef(NULL)

cdef bint pyxd_str_is_ready
cdef type PyXD_Str = type("xd_str", ((<object> PyArray_API[10]),), {})
pyxd_str_is_ready = PyType_Ready(<object> PyXD_Str)
(<PyTypeObject *> PyXD_Str).tp_basicsize = sizeof(PyXDStr_Type)
(<PyTypeObject *> PyXD_Str).tp_itemsize = 0
(<PyTypeObject *> PyXD_Str).tp_doc = "Python scalar type for std_string"
(<PyTypeObject *> PyXD_Str).tp_flags = Py_TPFLAGS_DEFAULT | Py_TPFLAGS_BASETYPE | Py_TPFLAGS_CHECKTYPES | Py_TPFLAGS_HEAPTYPE
(<PyTypeObject *> PyXD_Str).tp_alloc = pyxd_str_type_alloc
(<PyTypeObject *> PyXD_Str).tp_dealloc = pyxd_str_type_dealloc
(<PyTypeObject *> PyXD_Str).tp_new = pyxd_str_type_new
(<PyTypeObject *> PyXD_Str).tp_free = pyxd_str_type_free
(<PyTypeObject *> PyXD_Str).tp_str = pyxd_str_type_str
(<PyTypeObject *> PyXD_Str).tp_repr = pyxd_str_type_repr
(<PyTypeObject *> PyXD_Str).tp_base = (<PyTypeObject *> PyArray_API[10])  # PyGenericArrType_Type
(<PyTypeObject *> PyXD_Str).tp_hash = pyxd_str_type_hash
emit_ifpy2k()
(<PyTypeObject *> PyXD_Str).tp_compare = &pyxd_str_type_compare
emit_endif()
(<PyTypeObject *> PyXD_Str).tp_richcompare = pyxd_str_type_richcompare
(<PyTypeObject *> PyXD_Str).tp_members = pyxd_str_type_members
(<PyTypeObject *> PyXD_Str).tp_getset = pyxd_str_type_getset
pyxd_str_is_ready = PyType_Ready(<object> PyXD_Str)
Py_INCREF(PyXD_Str)
XDStr = PyXD_Str

cdef PyArray_Descr * c_xd_str_descr = <PyArray_Descr *> malloc(sizeof(PyArray_Descr))
(<PyObject *> c_xd_str_descr).ob_refcnt = 0 # ob_refcnt
(<PyObject *> c_xd_str_descr).ob_type = <PyTypeObject *> PyArray_API[3]
c_xd_str_descr.typeobj = <PyTypeObject *> PyXD_Str # typeobj
c_xd_str_descr.kind = 'x'  # kind, for xdress
c_xd_str_descr.type = 'x'  # type
c_xd_str_descr.byteorder = '='  # byteorder
c_xd_str_descr.flags = 0    # flags
c_xd_str_descr.type_num = 0    # type_num, assigned at registration
c_xd_str_descr.elsize = sizeof(std_string)  # elsize, 
c_xd_str_descr.alignment = 8  # alignment
c_xd_str_descr.subarray = NULL  # subarray
c_xd_str_descr.fields = NULL  # fields
c_xd_str_descr.names = NULL
(<PyArray_Descr *> c_xd_str_descr).f = <PyArray_ArrFuncs *> &PyXD_Str_ArrFuncs  # f == PyArray_ArrFuncs

cdef object xd_str_descr = <object> (<void *> c_xd_str_descr)
Py_INCREF(<object> xd_str_descr)
xd_str = xd_str_descr
cdef int xd_str_num = PyArray_RegisterDataType(c_xd_str_descr)
dtypes['str'] = xd_str
dtypes['xd_str'] = xd_str
dtypes[xd_str_num] = xd_str



# SetUInt
cdef class _SetIterUInt(object):
    cdef void init(self, cpp_set[xdress_extra_types.uint32] * set_ptr):
        cdef cpp_set[xdress_extra_types.uint32].iterator * itn = <cpp_set[xdress_extra_types.uint32].iterator *> malloc(sizeof(set_ptr.begin()))
        itn[0] = set_ptr.begin()
        self.iter_now = itn

        cdef cpp_set[xdress_extra_types.uint32].iterator * ite = <cpp_set[xdress_extra_types.uint32].iterator *> malloc(sizeof(set_ptr.end()))
        ite[0] = set_ptr.end()
        self.iter_end = ite

    def __dealloc__(self):
        free(self.iter_now)
        free(self.iter_end)

    def __iter__(self):
        return self

    def __next__(self):
        cdef cpp_set[xdress_extra_types.uint32].iterator inow = deref(self.iter_now)
        cdef cpp_set[xdress_extra_types.uint32].iterator iend = deref(self.iter_end)

        if inow != iend:

            pyval = int(deref(inow))
        else:
            raise StopIteration

        inc(deref(self.iter_now))
        return pyval


cdef class _SetUInt:
    def __cinit__(self, new_set=True, bint free_set=True):
        cdef xdress_extra_types.uint32 s


        # Decide how to init set, if at all
        if isinstance(new_set, _SetUInt):
            self.set_ptr = (<_SetUInt> new_set).set_ptr
        elif hasattr(new_set, '__iter__') or \
                (hasattr(new_set, '__len__') and
                hasattr(new_set, '__getitem__')):
            self.set_ptr = new cpp_set[xdress_extra_types.uint32]()
            for value in new_set:

                s = <xdress_extra_types.uint32> long(value)
                self.set_ptr.insert(s)
        elif bool(new_set):
            self.set_ptr = new cpp_set[xdress_extra_types.uint32]()

        # Store free_set
        self._free_set = free_set

    def __dealloc__(self):
        if self._free_set:
            del self.set_ptr

    def __contains__(self, value):
        cdef xdress_extra_types.uint32 s

        if isinstance(value, int):

            s = <xdress_extra_types.uint32> long(value)
        else:
            return False

        if 0 < self.set_ptr.count(s):
            return True
        else:
            return False

    def __len__(self):
        return self.set_ptr.size()

    def __iter__(self):
        cdef _SetIterUInt si = _SetIterUInt()
        si.init(self.set_ptr)
        return si

    def add(self, value):
        cdef xdress_extra_types.uint32 v


        v = <xdress_extra_types.uint32> long(value)
        self.set_ptr.insert(v)
        return

    def discard(self, value):
        cdef xdress_extra_types.uint32 v

        if value in self:

            v = <xdress_extra_types.uint32> long(value)
            self.set_ptr.erase(v)
        return


class SetUInt(_SetUInt, collections.Set):
    """Wrapper class for C++ standard library sets of type <unsigned integer>.
    Provides set like interface on the Python level.

    Parameters
    ----------
    new_set : bool or set-like
        Boolean on whether to make a new set or not, or set-like object
        with values which are castable to the appropriate type.
    free_set : bool
        Flag for whether the pointer to the C++ set should be deallocated
        when the wrapper is dereferenced.

    """
    def __str__(self):
        return self.__repr__()

    def __repr__(self):
        return "set([" + ", ".join([repr(i) for i in self]) + "])"



# Map(Int, Double)
cdef class _MapIterIntDouble(object):
    cdef void init(self, cpp_map[int, double] * map_ptr):
        cdef cpp_map[int, double].iterator * itn = <cpp_map[int, double].iterator *> malloc(sizeof(map_ptr.begin()))
        itn[0] = map_ptr.begin()
        self.iter_now = itn

        cdef cpp_map[int, double].iterator * ite = <cpp_map[int, double].iterator *> malloc(sizeof(map_ptr.end()))
        ite[0] = map_ptr.end()
        self.iter_end = ite

    def __dealloc__(self):
        free(self.iter_now)
        free(self.iter_end)

    def __iter__(self):
        return self

    def __next__(self):
        cdef cpp_map[int, double].iterator inow = deref(self.iter_now)
        cdef cpp_map[int, double].iterator iend = deref(self.iter_end)

        if inow != iend:

            pyval = int(deref(inow).first)
        else:
            raise StopIteration

        inc(deref(self.iter_now))
        return pyval

cdef class _MapIntDouble:
    def __cinit__(self, new_map=True, bint free_map=True):
        cdef pair[int, double] item



        # Decide how to init map, if at all
        if isinstance(new_map, _MapIntDouble):
            self.map_ptr = (<_MapIntDouble> new_map).map_ptr
        elif hasattr(new_map, 'items'):
            self.map_ptr = new cpp_map[int, double]()
            for key, value in new_map.items():


                item = pair[int, double](<int> key, <double> value)
                self.map_ptr.insert(item)
        elif hasattr(new_map, '__len__'):
            self.map_ptr = new cpp_map[int, double]()
            for key, value in new_map:


                item = pair[int, double](<int> key, <double> value)
                self.map_ptr.insert(item)
        elif bool(new_map):
            self.map_ptr = new cpp_map[int, double]()

        # Store free_map
        self._free_map = free_map

    def __dealloc__(self):
        if self._free_map:
            del self.map_ptr

    def __contains__(self, key):
        cdef int k

        if not isinstance(key, int):
            return False

        k = <int> key

        if 0 < self.map_ptr.count(k):
            return True
        else:
            return False

    def __len__(self):
        return self.map_ptr.size()

    def __iter__(self):
        cdef _MapIterIntDouble mi = _MapIterIntDouble()
        mi.init(self.map_ptr)
        return mi

    def __getitem__(self, key):
        cdef int k
        cdef double v


        if not isinstance(key, int):
            raise TypeError("Only integer keys are valid.")

        k = <int> key

        if 0 < self.map_ptr.count(k):
            v = deref(self.map_ptr)[k]

            return float(deref(self.map_ptr)[k])
        else:
            raise KeyError

    def __setitem__(self, key, value):


        cdef pair[int, double] item


        item = pair[int, double](<int> key, <double> value)
        if 0 < self.map_ptr.count(<int> key):
            self.map_ptr.erase(<int> key)
        self.map_ptr.insert(item)

    def __delitem__(self, key):
        cdef int k

        if key in self:

            k = <int> key
            self.map_ptr.erase(k)


class MapIntDouble(_MapIntDouble, collections.MutableMapping):
    """Wrapper class for C++ standard library maps of type <integer, double>.
    Provides dictionary like interface on the Python level.

    Parameters
    ----------
    new_map : bool or dict-like
        Boolean on whether to make a new map or not, or dict-like object
        with keys and values which are castable to the appropriate type.
    free_map : bool
        Flag for whether the pointer to the C++ map should be deallocated
        when the wrapper is dereferenced.
    """

    def __str__(self):
        return self.__repr__()

    def __repr__(self):
        return "{" + ", ".join(["{0}: {1}".format(repr(key), repr(value)) for key, value in self.items()]) + "}"



