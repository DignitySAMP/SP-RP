#define strmatch(%1,%2)                     (!strcmp(%1,%2,true))

#define HOLDING(%0) ((newkeys & (%0)) == (%0))
#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define PRESSING(%0, %1) (%0 & (%1))
#define RELEASED(%0) ((( newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == ( %0 )))

#define	RGBAtoARGB(%0) (%0 >>> 8 | %0 << 24)

#define RandomEx(%0,%1)                     (random((%1) - (%0)) + (%0))