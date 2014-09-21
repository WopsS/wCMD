// wCMD test

#define wCMD:%1(%2)          \
			forward wCMD_%1(%2); \
			public wCMD_%1(%2)	

#define COMMAND:%1(%2) wCMD:%1(%2)
#define CMD:%1(%2) wCMD:%1(%2)

#if !defined isnull
	#define isnull(%1) \
				((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif


static bool:wCMD_CMDS[2];

enum TypeValue
{
	None = 0,
	Command = 1,
	Arguments = 2
};

native wCMD(playerid, cmdtext[], TypeValue:type = None);
native WaitingThreads();

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
	wCMD(playerid, cmdtext, Command);
}

#if defined _ALS_OnPlayerCommandText
    #undef OnPlayerCommandText
#else
    #define _ALS_OnPlayerCommandText
#endif
#define OnPlayerCommandText wCMD_OnPlayerCommandText
forward wCMD_OnPlayerCommandText(playerid, cmdtext[]);