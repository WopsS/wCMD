// wCMD - Command Processor v0.0.1

#include <a_samp>

// zcmd
#define OnPlayerCommandText zcmd_OnPlayerCommandText
forward zcmd_OnPlayerCommandText(playerid, cmdtext[]);
#define _ALS_OnPlayerCommandText
#include <zcmd>

CMD:command(playerid, params[]) return 1;
//

// LifeCMD
#undef COMMAND
#undef CMD
#undef cmd
#undef OnPlayerCommandText

#define OnPlayerCommandText lcmd_OnPlayerCommandText
forward lcmd_OnPlayerCommandText(playerid, cmdtext[]);
#define LIFE_SPEED
#include <LIFE-CMD>

LIFE:command(playerid, params[]) return 1;
//

// YCMD
#undef COMMAND
#undef CMD
#undef OnPlayerCommandText
#define OnPlayerCommandText ycmd_OnPlayerCommandText
forward ycmd_OnPlayerCommandText(playerid, cmdtext[]);

#include <YSI\y_commands>

CMD:command(playerid, params[]) return 1;
//

// RCMD
#undef CMD
#undef COMMAND

#undef OnPlayerCommandText
#define OnPlayerCommandText rcmd_OnPlayerCommandText
forward rcmd_OnPlayerCommandText(playerid, cmdtext[]);
#include <r_cmd>

CMD:command(playerid, params[], pc) return 1;
//

// wCMD
#undef COMMAND
#undef CMD
#undef OnPlayerCommandText

#define OnPlayerCommandText wCMD_OnPlayerCommandText
forward wCMD_OnPlayerCommandText(playerid, cmdtext[]);

#define FAST_wCMD
#include <wCMD>

wCMD:command(playerid, params[]) return 1;
//

new Timer, MAXTESTS = 10, MAXCOMMANDS = 100;

main()
{
    new string[128];
    SPEED_TEST_LifeCMD();
    SPEED_TEST_RCMD();
    SPEED_TEST_YCMD();
    SPEED_TEST_zcmd();
	SPEED_TEST_wCMD();

	printf("%s", string);
	print("\n------------------------------------------------");
	print(" Speed test for command processors is finished.");
	print("------------------------------------------------\n");
}

stock SPEED_TEST_LifeCMD()
{
    print("Start testing LifeCMD ...\n");

  	MAXCOMMANDS = 100;

   	for(new i = 1; i <= MAXTESTS; i++)
    {
        Timer = GetTickCount();

		for(new d = 1; d <= MAXCOMMANDS; d++)
	     	lcmd_OnPlayerCommandText(0, "/command");

		printf("Test #%d: Finished %d ms, it used %d commands.", i, GetTickCount() - Timer,  MAXCOMMANDS);

		MAXCOMMANDS = MAXCOMMANDS + 100;
	}


	print("\nStop testing LifeCMD.\n");
}

stock SPEED_TEST_RCMD()
{
    print("Start testing RCMD ...\n");

  	MAXCOMMANDS = 100;

   	for(new i = 1; i <= MAXTESTS; i++)
    {
        Timer = GetTickCount();

		for(new d = 1; d <= MAXCOMMANDS; d++)
	     	rcmd_OnPlayerCommandText(0, "/command");

		printf("Test #%d: Finished %d ms, it used %d commands", i, GetTickCount() - Timer,  MAXCOMMANDS);

		MAXCOMMANDS = MAXCOMMANDS + 100;
	}


	print("\nStop testing RCMD.\n");
}

stock SPEED_TEST_YCMD()
{
    print("Start testing YCMD ...\n");

  	MAXCOMMANDS = 100;

   	for(new i = 1; i <= MAXTESTS; i++)
    {
        Timer = GetTickCount();

		for(new d = 1; d <= MAXCOMMANDS; d++)
	     	ycmd_OnPlayerCommandText(0, "/command");


		printf("Test #%d: Finished %d ms, it used %d commands.", i, GetTickCount() - Timer,  MAXCOMMANDS);

		MAXCOMMANDS = MAXCOMMANDS + 100;
	}

	print("\nStop testing YCMD.\n");
}

stock SPEED_TEST_zcmd()
{
    print("Start testing zcmd ...\n");

    MAXCOMMANDS = 100;

    for(new i = 1; i <= MAXTESTS; i++)
    {
        Timer = GetTickCount();

		for(new d = 1; d <= MAXCOMMANDS; d++)
	     	zcmd_OnPlayerCommandText(0, "/command");

		printf("Test #%d: Finished %d ms, it used %d commands.", i, GetTickCount() - Timer,  MAXCOMMANDS);
		MAXCOMMANDS = MAXCOMMANDS + 100;
	}

	print("\nStop testing zcmd.\n");
}

stock SPEED_TEST_wCMD()
{
    print("Start testing wCMD ...\n");

    MAXCOMMANDS = 100;

   	for(new i = 1; i <= MAXTESTS; i++)
    {
        Timer = GetTickCount();

		for(new d = 1; d <= MAXCOMMANDS; d++)
	     	wCMD_OnPlayerCommandText(0, "/command");

		printf("Test #%d: Finished %d ms, it used %d commands.", i, GetTickCount() - Timer,  MAXCOMMANDS);

		MAXCOMMANDS = MAXCOMMANDS + 100;
	}

	print("Stop testing wCMD.\n");
}
