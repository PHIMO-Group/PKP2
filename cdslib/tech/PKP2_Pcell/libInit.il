;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  libInit.il
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

let( ( ddObj (success t) (libName "PKP2_Pcell") )

    printf("Loading %s/libInit.il ...\n" libName)
    if( ddGetObj(libName) then
        ;; load custom library initialization file
        when( ddObj = ddGetObj(libName nil nil "libInitCustomEnter.il")
            printf("\tLoading %s/%s ... " libName ddObj~>name)
            if( errset(load(ddGetObjReadPath(ddObj))) then
                printf("done!\n")
            else
                success = nil
                printf("failed!\n")
            )
        ) ; ** when ddObj **

        ;; load loadCxt.ile
        unless( fboundp('PasLoadLibContext)
            when( ddObj = ddGetObj(libName nil nil "loadCxt.ile")
                if( errset(load(ddGetObjReadPath(ddObj))) then
                    printf("done!\n")
                else
                    success = nil
                    printf("failed!\n")
                );if
            ); when
        ) ; ** unless fboundp **
            
        when( ddObj = ddGetObj(libName nil nil strcat(libName "_cb64bit.cxt"))
            printf("\tLoading %s/%s ... " libName ddObj~>name)
            if( errset(loadContext(ddGetObjReadPath(ddObj) t)) then
                printf("done!\n")
            else
                success = nil
                printf("failed!\n")
            ) ; ** if errset **
        ) ; ** when ddObj **

        when( ddObj = ddGetObj(libName nil nil strcat(libName "_cpt64bit.cxt"))
            printf("\tLoading %s/%s ... " libName ddObj~>name)
            if( errset(loadContext(ddGetObjReadPath(ddObj) t)) then
                printf("done!\n")
            else
                success = nil
                printf("failed!\n")
            ) ; ** if errset **
        ) ; ** when ddObj **

        when( ddObj = ddGetObj(libName nil nil "pdaUtils64bit.cxt")
            printf("\tLoading %s/%s ... " libName ddObj~>name)
            if( errset(loadContext(ddGetObjReadPath(ddObj) t)) then
                printf("done!\n")
            else
                success = nil
                printf("failed!\n")
            ) ; ** if errset **
        ) ; ** when ddObj **



        pdkPath=ddGetObjReadPath(ddGetObj(libName))
        ;; load proc files        
        procFileDir = strcat(pdkPath "/.proc")
        if(isDir(procFileDir)  then
            printf("\tLoading proc files from library\n")
            procFileList = getDirFiles(procFileDir)
            foreach(procfile procFileList
                if(isFile(strcat(procFileDir "/" procfile)) then
                    if(!rexMatchp(".cxt$" procfile)    then
                        load(strcat(procFileDir "/" procfile) "pcelllab")
                    else
                        loadContext(strcat(procFileDir "/" procfile) t)
                    )
                )
            )
        )

        ;; load customer proc files
        ctmProcFileDir = strcat(procFileDir "/customer")
        if(isDir(ctmProcFileDir)  then
            ctmProcFileList = getDirFiles(ctmProcFileDir)
            foreach(ctmProcfile ctmProcFileList
                if(isFile(strcat(ctmProcFileDir "/" ctmProcfile)) then
                    if(!rexMatchp(".cxt$" ctmProcfile)    then
                        load(strcat(ctmProcFileDir "/" ctmProcfile) "pcelllab")
                    else
                        loadContext(strcat(ctmProcFileDir "/" ctmProcfile) t)
                    )
                )
            )
        )
 
        ;; load callback files       
        cbFileDir = strcat(pdkPath "/.callback")
        if(isDir(cbFileDir) then
            printf("\tLoading callback files from library\n")
            cbFileList = getDirFiles(cbFileDir)
            foreach(cbfile cbFileList
                if(isFile(strcat(cbFileDir "/" cbfile)) then
                    if(!rexMatchp(".cxt$" cbfile)    then
                        load(strcat(cbFileDir "/" cbfile) "pcelllab")
                    else
                        loadContext(strcat(cbFileDir "/" cbfile) t)
                    )
                )
            )
        )
       
        ;; load cpt files       
        cptFileDir = strcat(pdkPath "/.foundrydata")
        if(isDir(cptFileDir)  then
            printf("\tLoading cpt files from library\n")
            cptFileList = getDirFiles(cptFileDir)
            foreach(cptfile cptFileList
                if(isFile(strcat(cptFileDir "/" cptfile)) then
                    if(!rexMatchp(".cxt$" cptfile)    then
                        load(strcat(cptFileDir "/" cptfile) "pcelllab")
                    else
                        loadContext(strcat(cptFileDir "/" cptfile) t)
                    )
                )
            )
        )
        
        ;; load library .stop file
        when( ddObj = ddGetObj(libName nil nil ".stop")
            printf("\tLoading %s/%s ... " libName ddObj~>name)
            if( errset(PasEnvLoadFile(ddGetObjReadPath(ddObj))) then
                printf("done!\n")
            else
                success = nil
                printf("failed!\n")
            ) 
        ) ; ** when ddObj **
     

        ;; load library display resource file
        when(  fboundp(`drLoadDrf)     
            when( ddObj = ddGetObj(libName nil nil "display_bsc.drf")
                printf("\tLoading %s/%s ... " libName ddObj~>name)
                if( errset(drLoadDrf(ddGetObjReadPath(ddObj) nil)) then
                    printf("done!\n")
                else
                    success = nil
                    printf("failed!\n")
                )
            ) ; ** when ddObj **
        ) ; ** when fboundp **
     

        ;; set the number of digits to be displayed to 6
        when( fboundp('aelPushSignifDigits)
            aelPushSignifDigits(6)
        )

        ;; load circuit prospector configuration
        when( ddObj = ddGetObj(libName nil nil "libInitCktPro.il")
            printf("\tLoading %s/%s ... " libName ddObj~>name)
            if( errset(load(ddGetObjReadPath(ddObj))) then
                printf("done!\n")
            else
                success = nil
                printf("failed!\n")
            )
        ) ; ** when ddObj **
     
        ;; load custom library initialization file (exit)
        when( ddObj = ddGetObj(libName nil nil "libInitCustomExit.il")
            printf("\tLoading %s/%s ... " libName ddObj~>name)
            if( errset(load(ddGetObjReadPath(ddObj))) then
                printf("done!\n")
            else
                success = nil
                printf("failed!\n")
            )
        ) ; ** when ddObj **
    else
        success = nil
    ) ; ** if ddGetObj **

    if( success then
        printf("Loaded %s/libInit.il successfully!\n" libName)
    else
        printf("Failed to load %s/libInit.il successfully\n!" libName)
    )
  
  t
  
) ; ** let **

