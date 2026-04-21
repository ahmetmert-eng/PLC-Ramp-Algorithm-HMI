PROGRAM PLC_PRG
VAR
startbut:BOOL;
sistememory:BOOL;
stopbut:BOOL;
cyclic_time:real:=0.01;
set_hiz:REAL:=50;
aktuel_hiz:REAL:=0;
hizlanma_rampasi:REAL:=1;
yavaslama_rampasi:REAL:=1;
adim_miktari:REAL;
adim_miktari1:REAL;
ivme:REAL;
ivme1:REAL;
rMaxSpeed:REAL:=100;
rMinSpeed:REAL:=0;
hizlanma_suresi:REAL;
yavaslama_suresi:REAL;

END_VAR

ivme := (rMaxSpeed / hizlanma_rampasi);
ivme1 := (rMaxSpeed / yavaslama_rampasi);

adim_miktari := ivme * cyclic_time;
adim_miktari1 :=ivme1 * cyclic_time;

IF startbut THEN
    sistememory := TRUE;
END_IF

IF stopbut THEN
    sistememory := FALSE;
END_IF

IF sistememory AND set_hiz > aktuel_hiz THEN
    aktuel_hiz := LIMIT(rMinSpeed, adim_miktari + aktuel_hiz, set_hiz);
    hizlanma_suresi := (set_hiz - aktuel_hiz) / ivme;
END_IF

IF NOT sistememory AND aktuel_hiz > rMinSpeed THEN
    aktuel_hiz := LIMIT(rMinSpeed, aktuel_hiz -adim_miktari1 , rMaxSpeed);
    yavaslama_suresi := aktuel_hiz /ivme1;
END_IF

IF sistememory AND aktuel_hiz > set_hiz THEN
    aktuel_hiz := LIMIT(set_hiz, aktuel_hiz - adim_miktari1, rMaxSpeed);
    yavaslama_suresi := (aktuel_hiz - set_hiz) / ivme1;
END_IF
