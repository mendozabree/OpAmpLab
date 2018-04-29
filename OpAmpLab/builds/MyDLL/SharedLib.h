#include "extcode.h"
#pragma pack(push)
#pragma pack(1)

#ifdef __cplusplus
extern "C" {
#endif

/*!
 * GetValues
 */
void __stdcall GetValues(double Amp1[], double Time1[], int32_t len, 
	int32_t len2);
/*!
 * GetValuesOut
 */
void __stdcall GetValuesOut(double Amp2[], double Time2[], int32_t len, 
	int32_t len2);
/*!
 * Run
 */
void __stdcall Run(void);
/*!
 * SetParameters
 */
void __stdcall SetParameters(uint16_t Type, char DeviceName[], 
	double FrequencyHz, double AmplitudeVpp);

MgErr __cdecl LVDLLStatus(char *errStr, int errStrLen, void *module);

#ifdef __cplusplus
} // extern "C"
#endif

#pragma pack(pop)

