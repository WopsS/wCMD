#include "main.h"


void ProcessingThreadd(AMX* amx, cell* params)
{
	int Length = NULL;
	cell *Address = NULL;

	amx_GetAddr(amx, params[2], &Address);
	amx_StrLen(Address, &Length);

	if (Length > 0)
	{
		char* GetCommand = new char[++Length];
		char* GetArguments = new char[Length];
		//amx_GetString(GetCommand, Address, 0, Length);

		int i;

		for (i = 0; (i < Length) && (Address[i] != ' '); GetCommand[i] = Address[i++]);

		GetCommand[i - 1] = '\0';

		if (i == Length)
			GetArguments[0] = '\0';
		else
		{
			int j = i;
			for (i = i + 1; i < Length; GetArguments[i - j - 1] = Address[i++]);

			GetArguments[i - j - 1] = '\0';
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

		/*switch (params[3])
		{
		case Command:
			return char(ReceivedCommand.c_str());
			break;
		case Arguments:
			return char(ReceivedArguments.c_str());
			break;
		case None:
			logprintf(" * wCMD: There is no option valid.");
			return 0;
			break;
		}*/
	}
}

cell AMX_NATIVE_CALL ProcessingCommand(AMX* amx, cell* params)
{
	ThreadGroup.create_thread(bind(ProcessingThreadd, amx, params));

	return 0;
}

cell AMX_NATIVE_CALL WaitingThreads(AMX* amx, cell* params)
{
	ThreadGroup.join_all();

	return 0;
}

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
	{ "WaitingThreads", WaitingThreads },
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
