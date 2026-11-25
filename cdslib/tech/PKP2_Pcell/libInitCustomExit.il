
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  libInitCustomExit.il
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

let( ( ddObj (success t) (libName "PKP2_Pcell") )

    ;printf("Loading %s/libInitCustomEnter.il ...\n" libName)

    if( ddGetObj(libName) then

        ;;load VFO intrastructure in Third-Party Tools
        when( ddObj = ddGetObj(libName nil nil "load_vfo_context_and_files.il")
            printf("\tLoading %s/%s ... " libName ddObj~>name)
            if( errset(load(ddGetObjReadPath(ddObj))) then
                printf("done!\n")
                load_vfo_context_and_files(strcat(car(getInstallPath()) "/etc/context/64bit") strcat(car(getInstallPath()) "/etc/vfo"))
            else
                success = nil
                printf("failed!\n")
            )
        ) ; ** when ddObj **

   
        if( success then
            printf("Loaded %s/libInitCustomEnter.il successfully!\n" libName)
        else
            printf("Failed to load %s/libInitCustomEnter.il successfully!" libName)
        )
    ) ; if libName 

    if(isContextLoaded("schView") then
        envSetVal("asimenv.startup" "simulator" 'string "spectre")
        envSetVal("spectre.opts" "temp" 'string "25")
        envSetVal("hspiceD.opts" "PARHIER" 'string "GLOBAL")
        envSetVal("ams.opts" "temp" 'string "25")
        envSetVal("ams.ncverilogOpts" "additionalArg" 'string "-spectre_args +spice")
        envSetVal("spectre.opts" "redefinedparams" 'string "ignore")	
        envSetVal("spectre.opts" "gmin" 'string "1e-18")	
        envSetVal("spectre.opts" "gmindc" 'string "1e-18")	
        envSetVal("spectre.envOpts" "userCmdLineOption" 'string "+spice")

        libPath = ddGetObjReadPath(ddGetObj("PKP2_Pcell"))
        asiSetEnvOptionVal(asiGetTool('spectre) "modelFiles"
            list(
                list(strcat(libPath "/../models/spectre/***") "tt_mos")
                list(strcat(libPath "/../models/spectre/***") "tt_res")
            )
        )
       
       asiSetEnvOptionVal(asiGetTool('ams) "modelFiles"
           list(
               list(strcat(libPath "/../models/spectre/***") "tt_mos")
               list(strcat(libPath "/../models/spectre/***") "tt_res")
           )
       )

       asiSetEnvOptionVal(asiGetTool('hspiceD) "modelFiles"
           list(
               list(strcat(libPath "/../models/hspice/***") "tt_mos")
               list(strcat(libPath "/../models/hspice/***") "tt_res")
           )
       )
    );endif

    envSetVal("layoutXL" "initIOPinLayer" 'string "M1 drawing" )

    t

) ; ** let **


