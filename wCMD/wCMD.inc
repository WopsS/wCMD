// wCMD test

#define wCMD:%1(%2)          \
	forward wCMD_ % 1(% 2); \
	public wCMD_ % 1(% 2)

#define COMMAND:%1(%2) wCMD:%1(%2)
#define CMD:%1(%2) wCMD:%1(%2)
#define CALL::%1(%2) wCMD_%1(%2)

native wCMD(playerid, cmdtext[]);
native GetFormattedCommand(cmdtext[], string[], const stringsize = sizeof(string));
native GetCommandParameters(cmdtext[], string[], const stringsize = sizeof(string));

#if !defined isnull
#define isnull(%1) \
	((!(% 1[0])) || (((% 1[0]) == '\1') && (!(% 1[1]))))
#endif


static bool:wCMD_CMDS[2];

#if !defined FAST_wCMD

forward OnPlayerCommandExecuted(playerid, cmdtext[], success);
forward OnPlayerCommandAccepted(playerid, cmdtext[]);

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	wCMD_CMDS[0] = funcidx("OnPlayerCommandAccepted") != -1;
	wCMD_CMDS[1] = funcidx("OnPlayerCommandExecuted") != -1;

	return CallLocalFunction("wCMD_OnFilterScriptInit", "");
}

#define OnFilterScriptInit wCMD_OnFilterScriptInit
forward wCMD_OnFilterScriptInit();

#else

public OnGameModeInit()
{
	wCMD_CMDS[0] = funcidx("OnPlayerCommandAccepted") != -1;
	wCMD_CMDS[1] = funcidx("OnPlayerCommandExecuted") != -1;

	if (funcidx("wcmd_OnGameModeInit") != -1)
	{
		return CallLocalFunction("wcmd_OnGameModeInit", "");
	}

	return 1;
}

#if defined _ALS_OnGameModeInit
#undef OnGameModeInit
#else
#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit wcmd_OnGameModeInit
forward wcmd_OnGameModeInit();

#endif
#endif

public OnPlayerCommandText(playerid, cmdtext[])
{
	new Command[30], CommandParameters[128];

	GetFormattedCommand(cmdtext, Command);
	GetCommandParameters(cmdtext, CommandParameters);

#if defined FAST_wCMD
	if (isnull(CommandParameters))
	{
		if (wCMD_CMDS[1])
			return CallLocalFunction("OnPlayerCommandExecuted", "isi", playerid, cmdtext, CallLocalFunction(Command, "is", playerid, "\1"));

		return CallLocalFunction(Command, "is", playerid, "\1");
	}

	if (wCMD_CMDS[1])
		return CallLocalFunction("OnPlayerCommandExecuted", "isi", playerid, cmdtext, CallLocalFunction(Command, "is", playerid, CommandParameters));

#else
	if (wCMD_CMDS[0] && !CallLocalFunction("OnPlayerCommandAccepted", "is", playerid, cmdtext))
		return 1;

	if (isnull(CommandParameters))
	{
		if (wCMD_CMDS[1])
			return CallLocalFunction("OnPlayerCommandExecuted", "isi", playerid, cmdtext, CallLocalFunction(Command, "is", playerid, "\1"));

		return CallLocalFunction(Command, "is", playerid, "\1");
	}

	if (wCMD_CMDS[1])
		return CallLocalFunction("OnPlayerCommandExecuted", "isi", playerid, cmdtext, CallLocalFunction(Command, "is", playerid, CommandParameters));

#endif

	return CallLocalFunction(Command, "is", playerid, CommandParameters);
}

#if defined _ALS_OnPlayerCommandText
#undef OnPlayerCommandText
#else
#define _ALS_OnPlayerCommandText
#endif
#define OnPlayerCommandText wCMD_OnPlayerCommandText
forward wCMD_OnPlayerCommandText(playerid, cmdtext[]);