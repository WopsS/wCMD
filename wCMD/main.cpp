#include "main.h"


cell AMX_NATIVE_CALL ProcessingCommand(AMX* amx, cell* params)
{
	int Length = NULL;
	cell *Address = NULL;

	amx_GetAddr(amx, params[2], &Address);
	amx_StrLen(Address, &Length);

	if (Length >= 1)
	{
		char* GetCommand = new char[++Length];
		char* GetArguments = new char[Length];
		//amx_GetString(GetCommand, Address, 0, Length);

		int Index;

		for (Index = 0; (Index < Length) && (Address[Index] != ' '); GetCommand[Index] = Address[Index++]);

		GetCommand[Index - 1] = '\0';

		if (Index == Length)
			GetArguments[0] = '\0';
		else
		{
			int j = Index;
			for (Index = Index + 1; Index < Length; GetArguments[Index - j - 1] = Address[Index++]);

			GetArguments[Index - j - 1] = '\0';
		}

		string ReceivedCommand(GetCommand), ReceivedArguments(GetArguments);

		/*if (GetArguments[0] != '\0')
		ReceivedArguments = GetArguments;*/

		delete[] GetCommand;
		delete[] GetArguments;

		/*if (ReceivedCommand.find(string(" ")) != string::npos)
		{
		ReceivedArguments.erase(0, ReceivedCommand.erase(ReceivedCommand.find(string(" ")), UNLIMITED).length() + 1);
		}*/

		ReceivedCommand.erase(0, 1).insert(0, "wCMD_");
		char * string = new char[params[3]];
		amx_GetAddr(amx, params[3], &Address);
		amx_SetString(Address, ReceivedCommand.c_str(), 0, 0, params[3]);

		amx_GetAddr(amx, params[4], &Address);
		amx_SetString(Address, ReceivedArguments.c_str(), 0, 0, params[4]);
	}

	return 1;
}

//cell AMX_NATIVE_CALL ProcessingCommand(AMX* amx, cell* params)
//{
//	ThreadGroup.create_thread(bind(ProcessingThreadd, amx, params));
//	//ProcessingThreadd(amx, params);
//
//	return 0;
//}
//
//cell AMX_NATIVE_CALL WaitingThreads(AMX* amx, cell* params)
//{
//	ThreadGroup.join_all();
//
//	return 0;
//}

PLUGIN_EXPORT unsigned int PLUGIN_CALL Supports()
{
	return SUPPORTS_VERSION | SUPPORTS_AMX_NATIVES;
}

PLUGIN_EXPORT bool PLUGIN_CALL Load(void **ppData)
{
	pAMXFunctions = ppData[PLUGIN_DATA_AMX_EXPORTS];
	logprintf = (logprintf_t)ppData[PLUGIN_DATA_LOGPRINTF];

	logprintf(" >> wCMD plugin was loaded. \\ Version: "  Version  " \\ (c) 2014 Dima Octavian \"WopsS\". \n");
	return true;
}

PLUGIN_EXPORT void PLUGIN_CALL Unload()
{
	logprintf(" >> wCMD plugin was unloaded.");
}

AMX_NATIVE_INFO PluginNatives[] =
{
	{ "wCMD", ProcessingCommand },
	/*{ "WaitingThreads", WaitingThreads },*/
	{ 0, 0 }
};

PLUGIN_EXPORT int PLUGIN_CALL AmxLoad(AMX *amx)
{
	return amx_Register(amx, PluginNatives, -1);
}

PLUGIN_EXPORT int PLUGIN_CALL AmxUnload(AMX *amx)
{
	return AMX_ERR_NONE;
}
