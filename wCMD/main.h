#include <iostream>
#include <string>

#include <SDK/amx/amx.h>
#include <SDK/plugincommon.h>

#include <boost/thread.hpp>
#include <boost/chrono.hpp>

#define Version "0.0.3"

using namespace std;
using namespace boost;

typedef void(*logprintf_t)(char* format, ...);


logprintf_t logprintf;
extern void *pAMXFunctions;

thread_group ThreadGroup;

enum TypeValues 
{
	None = 0,
	Command = 1,
	Arguments = 2
};