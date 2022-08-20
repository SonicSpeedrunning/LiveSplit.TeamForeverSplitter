// Team Forever splitter
// Coding: Jujstme
// Version 2.0.3 (Jul 7th, 2022)
// S1F and S2A speedrunning discord: https://discord.com/invite/9JCcpDsSyA

/*
   Changelog
   - v.2.0.3: Added new sigscanning method compatible with all Sonic decompilations. This means added support for S1F v1.4.2 and, hopefully, the last release of the autosplitter
   - v.2.0.2: Fixed livesplit autostarting when selecting the options voice menu in S1F
*/

state ("SonicForever") {}
state ("Sonic2Absolute") {}

startup
{
    vars.s1Acts = new string[] { "GH1", "GH2", "GH3", "MZ1", "MZ2", "MZ3", "SY1", "SY2", "SY3", "LZ1", "LZ2", "LZ3", "SL1", "SL2", "SL3", "SB1", "SB2", "SB3", "FZ"};
    vars.s2Acts = new string[] { "EH1", "EH2", "CP1", "CP2", "AR1", "AR2", "CN1", "CN2", "HT1", "HT2", "MC1", "MC2", "OO1", "OO2", "MZ1", "MZ2", "MZ3", "SCZ", "WFZ", "DEZ"};

    string[,] Settings =
    {
        { "cleanSave",   "Autostart (Clean save)", null },
        { "newGamePlus", "Autostart (New Game+)", null },

        { "s1Autosplitting", "Sonic 1 Forever - Autosplitting", null },
            { "s1" + vars.s1Acts[0],  "Green Hill Zone - Act 1", "s1Autosplitting"},
            { "s1" + vars.s1Acts[1],  "Green Hill Zone - Act 2", "s1Autosplitting"},
            { "s1" + vars.s1Acts[2],  "Green Hill Zone - Act 3", "s1Autosplitting"},
            { "s1" + vars.s1Acts[3],  "Marble Zone - Act 1", "s1Autosplitting"},
            { "s1" + vars.s1Acts[4],  "Marble Zone - Act 2", "s1Autosplitting"},
            { "s1" + vars.s1Acts[5],  "Marble Zone - Act 3", "s1Autosplitting"},
            { "s1" + vars.s1Acts[6],  "Spring Yard Zone - Act 1", "s1Autosplitting"},
            { "s1" + vars.s1Acts[7],  "Spring Yard Zone - Act 2", "s1Autosplitting"},
            { "s1" + vars.s1Acts[8],  "Spring Yard Zone - Act 3", "s1Autosplitting"},
            { "s1" + vars.s1Acts[9],  "Labirynth Zone - Act 1", "s1Autosplitting"},
            { "s1" + vars.s1Acts[10], "Labirynth Zone - Act 2", "s1Autosplitting"},
            { "s1" + vars.s1Acts[11], "Labirynth Zone - Act 3", "s1Autosplitting"},
            { "s1" + vars.s1Acts[12], "Star Light Zone - Act 1", "s1Autosplitting"},
            { "s1" + vars.s1Acts[13], "Star Light Zone - Act 2", "s1Autosplitting"},
            { "s1" + vars.s1Acts[14], "Star Light Zone - Act 3", "s1Autosplitting"},
            { "s1" + vars.s1Acts[15], "Scrap Brain Zone - Act 1", "s1Autosplitting"},
            { "s1" + vars.s1Acts[16], "Scrap Brain Zone - Act 2", "s1Autosplitting"},
            { "s1" + vars.s1Acts[17], "Scrap Brain Zone - Act 3", "s1Autosplitting"},
            { "s1" + vars.s1Acts[18], "Final Zone", "s1Autosplitting"},

        { "s2Autosplitting", "Sonic 2 Absolute - Autosplitting", null},
            { "s2" + vars.s2Acts[0],  "Emerald Hill Zone - Act 1", "s2Autosplitting" },
            { "s2" + vars.s2Acts[1],  "Emerald Hill Zone - Act 2", "s2Autosplitting" },
            { "s2" + vars.s2Acts[2],  "Chemical Plant Zone - Act 1", "s2Autosplitting" },
            { "s2" + vars.s2Acts[3],  "Chemical Plant Zone - Act 2", "s2Autosplitting" },
            { "s2" + vars.s2Acts[4],  "Aquatic Ruin Zone - Act 1", "s2Autosplitting" },
            { "s2" + vars.s2Acts[5],  "Aquatic Ruin Zone - Act 2", "s2Autosplitting" },
            { "s2" + vars.s2Acts[6],  "Casino Night Zone - Act 1", "s2Autosplitting" },
            { "s2" + vars.s2Acts[7],  "Casino Night Zone - Act 2", "s2Autosplitting" },
            { "s2" + vars.s2Acts[8],  "Hill Top Zone - Act 1", "s2Autosplitting" },
            { "s2" + vars.s2Acts[9],  "Hill Top Zone - Act 2", "s2Autosplitting" },
            { "s2" + vars.s2Acts[10], "Mystic Cave Zone - Act 1", "s2Autosplitting" },
            { "s2" + vars.s2Acts[11], "Mystic Cave Zone - Act 2", "s2Autosplitting" },
            { "s2" + vars.s2Acts[12], "Oil Ocean Zone - Act 1", "s2Autosplitting" },
            { "s2" + vars.s2Acts[13], "Oil Ocean Zone - Act 2", "s2Autosplitting" },
            { "s2" + vars.s2Acts[14], "Metropolis Zone - Act 1", "s2Autosplitting" },
            { "s2" + vars.s2Acts[15], "Metropolis Zone - Act 2", "s2Autosplitting" },
            { "s2" + vars.s2Acts[16], "Metropolis Zone - Act 3", "s2Autosplitting" },
            { "s2" + vars.s2Acts[17], "Sky Chase Zone", "s2Autosplitting" },
            { "s2" + vars.s2Acts[18], "Wing Fortress Zone", "s2Autosplitting" },
            { "s2" + vars.s2Acts[19], "Death Egg Zone", "s2Autosplitting" }
    };
    for (int i = 0; i < Settings.GetLength(0); i++) settings.Add(Settings[i, 0], true, Settings[i, 1], Settings[i, 2]);

    vars.ZoneIndicator = new ExpandoObject();
    vars.ZoneIndicator.MainMenu = 0x6E69614Du;
    vars.ZoneIndicator.Zones = 0x656E6F5Au;
    vars.ZoneIndicator.Ending = 0x69646E45u;
    vars.ZoneIndicator.SaveSelect = 0x65766153u;
}

init
{
    // By default, assume you are running Sonic 2 Absolute.
    // Doesn't really matter though.
    switch (game.ProcessName)
    {
        case "SonicForever":
            vars.game = 1;
            version = "Sonic 1 Forever";
            break;
        default:
            vars.game = 2;
            version = "Sonic 2 Absolute";
            break;
    }

    // Inizialize the main watchers and the variables we need for sigscanning
    vars.watchers = new MemoryWatcherList();
    var ptr = IntPtr.Zero;
    var scanner = new SignatureScanner(game, modules.First().BaseAddress, modules.First().ModuleMemorySize);
    Action checkptr = () => { if (ptr == IntPtr.Zero) throw new Exception("Sigscanning failed!"); };

    // Custom black magic function made for sigscanning in sonic decomps
    Func<int, int, int, bool, IntPtr> pointerPath = (offset1, offset2, offset3, absolute) =>
    {
        // In 32bit games finding the path is very easy. Absolute is not needed in this case.
        if (!game.Is64Bit())
            return (IntPtr)new DeepPointer(ptr + offset1, offset2).Deref<int>(game) + offset3;
        // In 64bit executables it needs a little of work. Absolute will tell us if it's an absolute offset or if it's relative to MainModule.BaseAddress
        var tempOffset = modules.First().BaseAddress + game.ReadValue<int>(ptr + offset1) + offset2;
        if (absolute)
            return modules.First().BaseAddress + game.ReadValue<int>(tempOffset) + offset3;
        else
            return tempOffset + 0x4 + game.ReadValue<int>(tempOffset) + offset3;
    };

    switch (game.Is64Bit())
    {
        case false:
            version += " (32bit)";
            ptr = scanner.Scan(new SigScanTarget(14, "3D ???????? 0F 87 ???????? FF 24 85 ???????? A1") { OnFound = (p, s, addr) => (IntPtr)p.ReadValue<int>(addr) });
            checkptr();
            vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 *  (vars.game == 1 ? 73 : 89),  0x8, 0x9D8,  true)) { Name = "State"   });
            vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 123,  0x1,     0,  true)) { Name = "LevelID" });
            if (vars.game == 2)
            {
                vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 *  30,  0x8, 0x9D8,  true)) { Name = "StartIndicator"           });
                vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 *  91,  0x8, 0x9D8,  true)) { Name = "ZoneSelectOnGameComplete" });
            }

            ptr = scanner.Scan(new SigScanTarget(7,
                "69 F8 ????????",   // imul edi,eax,000000C1
                "B8 ????????")      // mov eax,SonicForever.exe+48DC990
            { OnFound = (p, s, addr) => (IntPtr)p.ReadValue<int>(addr) });
            checkptr();
            vars.watchers.Add(new MemoryWatcher<uint>(ptr) { Name = "ZoneIndicator" });
            break;

        case true:
            version += " (64bit)";
            // Only Sonic 1 Forever has a 64bit exe
            ptr = scanner.Scan(new SigScanTarget(16, "81 F9 ???????? 0F 87 ???????? 41 8B 8C") { OnFound = (p, s, addr) => modules.First().BaseAddress + p.ReadValue<int>(addr) });
            checkptr();
            vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 123,  0x2,     0,  false)) { Name = "LevelID" });

            ptr = scanner.Scan(new SigScanTarget(3,
                "48 8D 2D ????????",    // lea rbp,[SonicForever.exe+37C730]
                "FF C7")                // inc edi
            { OnFound = (p, s, addr) => addr + 0x4 + p.ReadValue<int>(addr) });
            checkptr();
            vars.watchers.Add(new MemoryWatcher<byte>(ptr + 0x9D8 + 0x14) { Name = "State" });

            ptr = scanner.Scan(new SigScanTarget(2,
                "C6 05 ???????? ??",    // mov byte ptr [SonicForever.exe+5EC0B0],00  <---
                "E9 ????????",          // jmp SonicForever.exe+2B0C0
                "48 8D 0D ????????")    // lea rcx,[SonicForever.exe+8B580]
            { OnFound = (p, s, addr) => addr + 0x5 + p.ReadValue<int>(addr) });
            checkptr();
            vars.watchers.Add(new MemoryWatcher<uint>(ptr) { Name = "ZoneIndicator" });
            break;
    }

    // Defining variables used later in the script
    current.Act = 0;
    current.StartingNewGame = false;
    current.RunStartedSaveFile = false;
    current.RunStartedNoSaveFile = false;
    current.RunStartedNGP = false;
}

update
{
    vars.watchers.UpdateAll(game);
    current.Act = vars.watchers["ZoneIndicator"].Current == vars.ZoneIndicator.Ending ? -1 : vars.watchers["ZoneIndicator"].Current == vars.ZoneIndicator.Zones ? vars.watchers["LevelID"].Current : old.Act;
}

start
{
    switch ((byte)vars.game)
    {
        case 1:
            current.RunStartedSaveFile = vars.watchers["State"].Changed && vars.watchers["State"].Current == 2 && vars.watchers["ZoneIndicator"].Current == vars.ZoneIndicator.SaveSelect;
            current.RunStartedNoSaveFile = vars.watchers["State"].Old == 6 && vars.watchers["State"].Current == 7;
            current.RunStartedNGP = vars.watchers["State"].Old == 8 && vars.watchers["State"].Current == 9;
            break;

        case 2:
            current.RunStartedSaveFile = vars.watchers["State"].Old == 5 && vars.watchers["State"].Current == 7;
            current.RunStartedNoSaveFile = vars.watchers["State"].Current == 4 && vars.watchers["StartIndicator"].Changed && vars.watchers["StartIndicator"].Current == 1;
            current.RunStartedNGP = vars.watchers["State"].Current == 6 && vars.watchers["StartIndicator"].Changed && vars.watchers["StartIndicator"].Current == 1 && vars.watchers["ZoneSelectOnGameComplete"].Current == 0;
            break;
    }

    return
        ( settings["cleanSave"] && ( (!old.RunStartedSaveFile && current.RunStartedSaveFile) || (!old.RunStartedNoSaveFile && current.RunStartedNoSaveFile) ) )
        || ( settings["newGamePlus"] && !old.RunStartedNGP && current.RunStartedNGP );
}

split
{
    if (current.Act == old.Act + 1)
    {
        for (int i = 0; i < (vars.game == 1 ? vars.s1Acts : vars.s2Acts).Length; i++)
        {
            if (old.Act == i && settings["s" + vars.game.ToString() + (vars.game == 1 ? vars.s1Acts : vars.s2Acts)[i]]) return true;
        }
    }
    else if ( settings["s" + vars.game.ToString() + (vars.game == 1 ? vars.s1Acts[18] : vars.s2Acts[19])] && old.Act != current.Act && current.Act == -1 )
    {
        return true;
    }
}

reset
{
    switch ((byte)vars.game)
    {
        case 1:
            current.StartingNewGame = vars.watchers["State"].Current == 201 && vars.watchers["State"].Old == 200 && vars.watchers["ZoneIndicator"].Current == vars.ZoneIndicator.SaveSelect;
            break;
        case 2:
            current.StartingNewGame = vars.watchers["State"].Old == 0 && (vars.watchers["State"].Current == 4 || vars.watchers["State"].Current == 5);
            break;
    }

    return !old.StartingNewGame && current.StartingNewGame;
}
