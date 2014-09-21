// wCMD - Command Processor v0.0.1

#include <a_samp>

// zcmd
#define OnPlayerCommandText zcmd_OnPlayerCommandText
forward zcmd_OnPlayerCommandText(playerid, cmdtext[]);
#define _ALS_OnPlayerCommandText
#include <zcmd>

CMD:command1(playerid, params[]) return 1;
CMD:command2(playerid, params[]) return 1;
CMD:command3(playerid, params[]) return 1;
CMD:command4(playerid, params[]) return 1;
CMD:command5(playerid, params[]) return 1;
CMD:command6(playerid, params[]) return 1;
CMD:command7(playerid, params[]) return 1;
CMD:command8(playerid, params[]) return 1;
CMD:command9(playerid, params[]) return 1;
CMD:command10(playerid, params[]) return 1;
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

LIFE:command1(playerid, params[]) return 1;
LIFE:command2(playerid, params[]) return 1;
LIFE:command3(playerid, params[]) return 1;
LIFE:command4(playerid, params[]) return 1;
LIFE:command5(playerid, params[]) return 1;
LIFE:command6(playerid, params[]) return 1;
LIFE:command7(playerid, params[]) return 1;
LIFE:command8(playerid, params[]) return 1;
LIFE:command9(playerid, params[]) return 1;
LIFE:command10(playerid, params[]) return 1;
//

// YCMD
#undef COMMAND
#undef CMD
#undef OnPlayerCommandText
#define OnPlayerCommandText ycmd_OnPlayerCommandText
forward ycmd_OnPlayerCommandText(playerid, cmdtext[]);

#include <YSI\y_commands>

CMD:command1(playerid, params[]) return 1;
CMD:command2(playerid, params[]) return 1;
CMD:command3(playerid, params[]) return 1;
CMD:command4(playerid, params[]) return 1;
CMD:command5(playerid, params[]) return 1;
CMD:command6(playerid, params[]) return 1;
CMD:command7(playerid, params[]) return 1;
CMD:command8(playerid, params[]) return 1;
CMD:command9(playerid, params[]) return 1;
CMD:command10(playerid, params[]) return 1;
//

// RCMD
#undef CMD
#undef COMMAND

#undef OnPlayerCommandText
#define OnPlayerCommandText rcmd_OnPlayerCommandText
forward rcmd_OnPlayerCommandText(playerid, cmdtext[]);
#include <r_cmd>

CMD:command1(playerid, params[], pc) return 1;
CMD:command2(playerid, params[], pc) return 1;
CMD:command3(playerid, params[], pc) return 1;
CMD:command4(playerid, params[], pc) return 1;
CMD:command5(playerid, params[], pc) return 1;
CMD:command6(playerid, params[], pc) return 1;
CMD:command7(playerid, params[], pc) return 1;
CMD:command8(playerid, params[], pc) return 1;
CMD:command9(playerid, params[], pc) return 1;
CMD:command10(playerid, params[], pc) return 1;
//

// wCMD
#undef COMMAND
#undef CMD
#undef OnPlayerCommandText

#define OnPlayerCommandText wCMD_OnPlayerCommandText
forward wCMD_OnPlayerCommandText(playerid, cmdtext[]);

#define FAST_wCMD
#include <wCMD>

wCMD:command1(playerid, params[]) return 1;
wCMD:command2(playerid, params[]) return 1;
wCMD:command3(playerid, params[]) return 1;
wCMD:command4(playerid, params[]) return 1;
wCMD:command5(playerid, params[]) return 1;
wCMD:command6(playerid, params[]) return 1;
wCMD:command7(playerid, params[]) return 1;
wCMD:command8(playerid, params[]) return 1;
wCMD:command9(playerid, params[]) return 1;
wCMD:command10(playerid, params[]) return 1;
//

new Timer, MAXTESTS = 10, MAX_REPEATS = 100, MAXCOMMANDS = 100;
new Length[12];

main()
{
    //SPEED_TEST_LifeCMD();
    //SPEED_TEST_RCMD();
    //SPEED_TEST_YCMD();
    //SPEED_TEST_zcmd();
	SPEED_TEST_wCMD();


	print("\n------------------------------------------------");
	print(" Speed test for command processors is finished.");
	print("------------------------------------------------\n");
}

stock SPEED_TEST_LifeCMD()
{
    print("Start testing LifeCMD ...\n");

  	MAXCOMMANDS = 100;
	MAX_REPEATS = 100;

   	for(new i = 1; i <= MAXTESTS; i++)
    {
        Timer = GetTickCount();

        for(new r = 1; r <= MAX_REPEATS; r++)
		{
			for(new d = 1; d <= MAXCOMMANDS; d++)
			{
			    format(Length, sizeof(Length), "/command%i", d);
		     	lcmd_OnPlayerCommandText(0, Length);
			}
		}

		printf("Test #%d: Finished %d ms, it used %d commands, it was repeated %d times.", i, GetTickCount() - Timer,  MAXCOMMANDS, MAX_REPEATS);

		MAXCOMMANDS = MAXCOMMANDS + 100;
		MAX_REPEATS = MAX_REPEATS + 150;
	}


	print("\nStop testing LifeCMD.\n");
}

stock SPEED_TEST_RCMD()
{
    print("Start testing RCMD ...\n");

  	MAXCOMMANDS = 100;
	MAX_REPEATS = 100;

   	for(new i = 1; i <= MAXTESTS; i++)
    {
        Timer = GetTickCount();

        for(new r = 1; r <= MAX_REPEATS; r++)
		{
			for(new d = 1; d <= MAXCOMMANDS; d++)
			{
			    format(Length, sizeof(Length), "/command%i", d);
		     	rcmd_OnPlayerCommandText(0, Length);
			}
		}

		printf("Test #%d: Finished %d ms, it used %d commands, it was repeated %d times.", i, GetTickCount() - Timer,  MAXCOMMANDS, MAX_REPEATS);

		MAXCOMMANDS = MAXCOMMANDS + 100;
		MAX_REPEATS = MAX_REPEATS + 150;
	}


	print("\nStop testing RCMD.\n");
}

stock SPEED_TEST_YCMD()
{
    print("Start testing YCMD ...\n");

  	MAXCOMMANDS = 100;
	MAX_REPEATS = 100;

   	for(new i = 1; i <= MAXTESTS; i++)
    {
        Timer = GetTickCount();

        for(new r = 1; r <= MAX_REPEATS; r++)
		{
			for(new d = 1; d <= MAXCOMMANDS; d++)
			{
			    format(Length, sizeof(Length), "/command%i", d);
		     	ycmd_OnPlayerCommandText(0, Length);
			}
		}

		printf("Test #%d: Finished %d ms, it used %d commands, it was repeated %d times.", i, GetTickCount() - Timer,  MAXCOMMANDS, MAX_REPEATS);

		MAXCOMMANDS = MAXCOMMANDS + 100;
		MAX_REPEATS = MAX_REPEATS + 150;
	}

	print("\nStop testing YCMD.\n");
}

stock SPEED_TEST_zcmd()
{
    print("Start testing zcmd ...\n");

    MAXCOMMANDS = 100;
	MAX_REPEATS = 100;

    for(new i = 1; i <= MAXTESTS; i++)
    {
        Timer = GetTickCount();

        for(new r = 1; r <= MAX_REPEATS; r++)
		{
			for(new d = 1; d <= MAXCOMMANDS; d++)
			{
			    format(Length, sizeof(Length), "/command%i", d);
		     	zcmd_OnPlayerCommandText(0, Length);
			}
		}

		printf("Test #%d: Finished %d ms, it used %d commands, it was repeated %d times.", i, GetTickCount() - Timer,  MAXCOMMANDS, MAX_REPEATS);
		MAXCOMMANDS = MAXCOMMANDS + 100;
		MAX_REPEATS = MAX_REPEATS + 150;
	}

	print("\nStop testing zcmd.\n");
}

stock SPEED_TEST_wCMD()
{
    print("Start testing wCMD ...\n");

    MAXCOMMANDS = 100;
	MAX_REPEATS = 100;

   	for(new i = 1; i <= MAXTESTS; i++)
    {
        Timer = GetTickCount();

        for(new r = 1; r <= MAX_REPEATS; r++)
		{
			for(new d = 1; d <= MAXCOMMANDS; d++)
			{
       			format(Length, sizeof(Length), "/command%i", d);
		     	wCMD_OnPlayerCommandText(0, Length);
			}
			WaitingThreads();
		}
		printf("Test #%d: Finished %d ms, it used %d commands, it was repeated %d times.", i, GetTickCount() - Timer,  MAXCOMMANDS, MAX_REPEATS);

		MAXCOMMANDS = MAXCOMMANDS + 100;
		MAX_REPEATS = MAX_REPEATS + 150;
	}

	print("Stop testing wCMD.\n");
}
