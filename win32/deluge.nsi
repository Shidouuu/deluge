; Deluge Windows Installer Script
; Written By John Garland <johnnybg@gmail.com>
; Date: 21/02/09

; Includes

    !include "MUI2.nsh"

; General Settings

    ; Name
    Name "Deluge"
    OutFile "deluge.exe"

    ; Default install dir
    InstallDir "$PROGRAMFILES"

; Dependencies

    !define LIBTORRENT

; Interface Settings

    !define MUI_ABORTWARNING

; Pages

    ; Installation

        !insertmacro MUI_PAGE_WELCOME
        !insertmacro MUI_PAGE_LICENSE "..\LICENSE"
        !insertmacro MUI_PAGE_COMPONENTS
        !insertmacro MUI_PAGE_DIRECTORY
        !insertmacro MUI_PAGE_INSTFILES
        !insertmacro MUI_PAGE_FINISH

    ; Uninstallation
    
        !insertmacro MUI_UNPAGE_CONFIRM
        !insertmacro MUI_UNPAGE_INSTFILES
        !insertmacro MUI_UNPAGE_FINISH

; Languages

    !insertmacro MUI_LANGUAGE "English"
    ; Should put all languages deluge supports here

; Installer Sections

Section "Deluge Core" deluge

    SectionIn RO

    SetOutPath "$INSTDIR\Deluge"

    WriteUninstaller "$INSTDIR\uninstall.exe"

SectionEnd

SubSection /e "Dependencies" deps

    Section "Libtorrent" libtorrent

        SectionIn 1

        ; Download MSI
        NSIS:dl download ${LIBTORRENT_URL} "$TEMP\${LIBTORRENT}"

        ; Install MSI
        delete "$TEMP\${LIBTORRENT}"

    SectionEnd

SubSectionEnd

; Descriptions

    ; Language strings
    LangString DESC_deluge ${LANG_ENGLISH} "Core section."

    ; Assign language strings to sections
    !insertmacro  MUI_FUNCTION_DESCRIPTION_BEGIN
        !insertmacro MUI_DESCRIPTION_TEXT ${deluge} $(DESC_deluge)
    !insertmacro  MUI_FUNCTION_DESCRIPTION_END

; Uninstaller Section

Section "Uninstall"

    Delete "$INSTDIR\README"
    Delete "$INSTDIR\uninstall.exe"

    RMDir "$INSTDIR"

SectionEnd
