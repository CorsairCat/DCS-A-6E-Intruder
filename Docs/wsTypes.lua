-- **************** 1 level ***************
wsType_Air      = 1
wsType_Ground   = 2
wsType_Navy     = 3
wsType_Weapon   = 4
wsType_Static   = 5
wsType_Destroyed  = 6
wsType_Test1    = 200
wsType_Point    = 201

-- **************** 2 level ***************
-- Air objects (wType_Air)
wsType_Airplane   = 1
wsType_Helicopter = 2
wsType_Free_Fall  = 3
-- Weapon (wsType_Weapon)
wsType_Missile    	= 4
wsType_Bomb       	= 5
wsType_Shell    	= 6
wsType_NURS       	= 7
wsType_Torpedo		= 8
-- Ground objects (wsType_Ground)
wsType_Moving   = 8
wsType_Standing   = 9
wsType_Tank     = 17
wsType_SAM      = 16
--  Navy objects  (wsType_Navy)
wsType_Ship         = 12
--  object (wsType_Static)
wsType_Airdrome   = 13
wsType_Explosion    = 14

wsType_GContainer   = 15
wsType_AirdromePart = 18
wsType_WingPart   = 19

-- **************** 3 level ***************
-- Air objects, wsType_Airplane
wsType_Fighter    = 1
wsType_F_Bomber   = 2
wsType_Intercepter  = 3
wsType_Intruder   = 4
wsType_Cruiser    = 5
wsType_Battleplane  = 6
-- Free-fall air objects
wsType_Snars    = 31
wsType_Parts    = 35
wsType_FuelTank   = 43
-- wsType_Missile
wsType_AA_Missile = 7
wsType_AS_Missile = 8
wsType_SA_Missile = 34
wsType_SS_Missile = 11

wsType_A_Torpedo = 10
wsType_S_Torpedo = 11

wsType_AA_TRAIN_Missile = 100
wsType_AS_TRAIN_Missile = 101

-- wsType_Bomb
wsType_Bomb_A       = 9
wsType_Bomb_Guided  = 36
wsType_Bomb_BetAB   = 37
wsType_Bomb_Cluster = 38
wsType_Bomb_Antisubmarine = 39
wsType_Bomb_ODAB    = 40
wsType_Bomb_Fire    = 41
wsType_Bomb_Nuclear = 42
wsType_Bomb_Lighter = 49
-- wsType_Shell
wsType_Shell_A    = 10

-- Navy objects (wsType_Navy, wsType_Cruiser)
wsType_AirCarrier = 12
wsType_HCarrier     = 13
wsType_ArmedShip    = 14
wsType_CivilShip    = 15
wsType_Submarine	= 16
--         wsType_Airdrome
wsType_RW1          = 20
wsType_RW2          = 30
wsType_Heliport   = 40
--  wsType_Explosion
wsType_GroundExp    = 29
--           wsType_NURS
wsType_Container    = 32
wsType_Rocket       = 33
--           wsType_GContainer
wsType_Control_Cont = 44
wsType_Jam_Cont     = 45
wsType_Cannon_Cont  = 46
wsType_Support      = 47
wsType_Snare_Cont   = 48
wsType_Smoke_Cont   = 50
  
--  Ground object (wsType_Moving || wsType_Standing )
wsType_NoWeapon     = 25
wsType_Gun          = 26
wsType_Miss         = 27
wsType_ChildMiss    = 28
wsType_MissGun      = 104
wsType_Civil        = 100
--***************************************************
--
wsType_Radar     = 101
wsType_Radar_Miss    = 102
wsType_Radar_MissGun = 103
wsType_Radar_Gun     = 105





-- **************** 4 level ***************
-- Free-fall air objects; parts
wsType_OBLOMOK_1  =   1;  -- 1-� ������� ��������
wsType_OBLOMOK_2  =   2;  -- 2-� ������� ��������
wsType_OBLOMOK_3  =   3;  -- 3-� ������� ��������
wsType_OBLOMOK_4  =   4;  -- 4-� ������� ��������
wsType_OBLOMOK_5  =   5;  -- 5-� ������� ��������
wsType_OBLOMOK_6  =   6;  -- 6-� ������� ��������
OBLOMOK_OBSHIWKI_1  =   7;  -- ������� �������
OBLOMOK_OBSHIWKI_2  =   8;  -- ������� �������
K36               =   9;  -- ����������. ������
PILOT_K36           =  10;  -- ����� � ������ K36 ��� �������������.
PILOT_PARASHUT      =  11;  -- ����� RUS ��� ���������
FONAR_OTK           =  12;  -- ���������� ������
-- Free-fall air objects - snars
wsType_Chaff    =  13;  -- �����-�������
wsType_Flare    =  14;  -- �������� �������
wsType_ShortMTail   =  15;  -- �������� ����� �����
wsType_SmallBomb  =  16;  -- ����� �� �������
PILOT_ACER          =  17;  -- ����� � ������ ACER ��� �������������.
PILOT_F14_SEAT      =  18;  -- �����  F14 � ������ ��� �������������.
PILOT_PARASHUT_US   =  19;  -- ����� US ��� ���������
A_10_FONAR        =  20;  -- ���������� ������ �������� �-10
F_14A_FONAR       =  21;  -- ���������� ������ �������� F-14A     
F_15_FONAR        =  22;  -- ���������� ������ �������� F-15
F_16_FONAR        =  23;  -- ���������� ������ �������� F-16
F_18C_FONAR         =  24;  -- ���������� ������ �������� F-18C
MIG_23_FONAR        =  25;  -- ���������� ������ �������� ���-23
MIG_25_FONAR        =  26;  -- ���������� ������ �������� ���-25
MIG_27_FONAR        =  27;  -- ���������� ������ �������� ���-27
MIG_29_FONAR      =  28;  -- ���������� ������ �������� ���-29
MIG_29K_FONAR     =  29;  -- ���������� ������ �������� ���-29�
MIG_31_FONAR_P    =  30;  -- ���������� ������ �������� ���-31 (�������� ������)
MIG_31_FONAR_Z    =  31;  -- ���������� ������ �������� ���-31 (������ ������)
SU_24_FONAR_L     =  32;  -- ���������� ������ �������� ��-24 (����� ������)
SU_24_FONAR_R     =  33;  -- ���������� ������ �������� ��-24 (������ ������)
SU_25_FONAR       =  34;  -- ���������� ������ �������� ��-25
SU_27_FONAR     =  35;  -- ���������� ������ �������� ��-27
SU_30_FONAR     =  36;  -- ���������� ������ �������� ��-30
SU_33_FONAR       =  37;  -- ���������� ������ �������� ��-33
SU_39_FONAR       =  38;  -- ���������� ������ �������� ��-39

TORNADO_FONAR     =  39;  -- ���������� ������ �������� TORNADO
Mirage_FONAR      =  40;  -- ���������� ������ �������� Mirage
F_4_FONAR_P     =  41;  -- ���������� ������ �������� F-4 ��������
F_4_FONAR_Z     =  42;  -- ���������� ������ �������� F-4 ������
F_5_FONAR     =  43;  -- ���������� ������ �������� F-5
SU_17_FONAR     =  44;  -- ���������� ������ �������� C�-17
SU_34_FONAR_L     =  45;  -- ���������� ������ �������� ��-34 (����� ������)
SU_34_FONAR_R     =  46;  -- ���������� ������ �������� ��-34 (������ ������)
MIG_29C_FONAR     =  47;  -- ���������� ������ �������� ���-29
MIG_29G_FONAR     =  48;  -- ���������� ������ �������� ���-29
SU_25T_FONAR      =  49;  -- ���������� ������ �������� ��-25�
wsType_Flare_GREEN  =  50;-- ���������� ������ �������
wsType_Flare_RED    =  51;-- ���������� ������ �������
wsType_Flare_WHITE  =  52;-- ���������� ������ �����
wsType_Flare_YELLOW =  53;-- ���������� ������ ������

PILOT_DEAD      =  54;-- ���� ������
PARACHUTE_ON_GROUND =  55;-- �������� �����



-- ������
GROUND_EXP          = 1;  -- ��������  ����� 1  

Heliport_standart = 100; -- ������������

-- ������ ����������
Airdrome_0          = 0;  -- �������� 0   
Khersones         = 1;  -- ��������
Saki              = 2;  -- ����
Simpheropol         = 3;  -- ����������� �����������
Razdolnoe           = 4;  -- ���������� 
Dzhankoy          = 5;  -- �������
Kirovskoe         = 6;  -- ���������
Kerch             = 7;  -- �������� (�����)
Belbek            = 8;  -- �������
Krasnogvardeyskoye  = 9;  -- �����������������
Octyabrskoe         = 10; -- �����������
Gvardeyskoe         = 11; -- ����������� �������
Anapa       = 12; -- �����
Krasnodar     = 13; -- ��������� �����������
Novorossiysk    = 14; -- ������������
Krymsk        = 15; -- ������
Maykop        = 16; -- ������
Gelendzhik      = 17; -- ���������
Sochi       = 18; -- ���� (�����)
Krasnodar_P     = 19; -- ��������� 
Sukhumi       = 20; -- ������
Gudauta       = 21; -- �������
Batumi        = 22; -- ������
Tskhakaya     = 23; -- ������
Kobuleti      = 24; -- ��������
Kutaisi       = 25; -- �������
MinVody       = 26;
Nalchick      = 27;
Mozdok              = 28 -- ���������� ��������
Lochini             = 29 -- ����������� �������� � �������
TbilisiMilitary     = 30 -- ������� �������� �������
Vaziani             = 31 -- ������� �������� �������
Beslan              = 32 -- �����������-������

--#ifndef DEMO_VERSION
LAST_AIRDROME_TYPE = Nalchick; 
--#else
--LAST_AIRDROME_TYPE = Gvardeyskoe; 
--#endif DEMO_VERSION
------------------------------------------------------------------------/
-- !!! ��� ���������� ���������� �������������� LAST_AIRDROME_TYPE !!! --
------------------------------------------------------------------------/
wsType_RunWay   = 100;

-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--        Airplanes list.       ������ ���������
------------------------------------------------------------------------/
-- !!! ��� ���������� ����� ��������� �������������� LastPlaneType !!! --
------------------------------------------------------------------------/
--  ����������� � ������������ ��������.
MiG_23  =  1; -- MiG-23 Flogger 
MiG_29  =  2; -- MiG-29 Fulcrum 
Su_27   =  3; -- Su-27 Flanker  
Su_33   =  4;   -- Su-33            
F_14    =  5;   -- F-14 Tomcat              
F_15    =  6;   -- F-15 Eagle   
F_16    =  7;   -- F-16 Fighting Falcon
-- ������������.
MiG_25  =  8;   -- MiG-25 Foxbat  
MiG_31  =  9;   -- MiG-31 Foxhound  
F_2     =  10;  -- Tornado F.2 IDS GR.1A  
-- �����������-����a����������.
MiG_27  =  11;  -- MiG-27 Flogger-D 
Su_24   =  12;  -- Su-24 Fencer   
Su_30   =  13;  -- Su-30            
FA_18   =  14;  -- F/A-18A Hornet           
F_111   =  15;  -- F-111  
-- ����������.
Su_25   =  16;  -- Su-25 Frogfoot 
A_10A   =  17;  -- A-10A Thunderbolt II
-- �������������� ���������������.
Tu_160  =  18;  -- Tu-160 Blackjack         
B_1     =  19;  -- B-1 Lancer           
Su_34   =  20;  -- C�-34 �����������-����a���������
Tu_95   =  21;  -- Tu-95 Bear 
Tu_142  =  22;  -- Tu-142 Bear  
B_52    =  23;  -- B-52 Stratofortress          
-- ���������������.
MiG_25P =  24;  -- MiG_25P -- �����������
Tu_22M3 =  25;  -- Tu-22M3 Backfire 
-- �����.
A_50    =  26;  -- �-50 Mainstay
E_3     =  27;  -- E-3 Sentry           
-- �������� ����������
IL_78   =  28;  -- IL-78 Midas            
KC_10   =  29;  -- KC-10 Extender           
-- ������������ ��������.
IL_76   =  30;  -- IL-76 Candid 
C_130   =  31;  -- C-130 Hercules
MIG_29K =  32;  -- MiG-29K - �����������            
S_3R  =  33;  -- S-3A VICING, ��������, ���������           
Mirage  =  34;  -- Mirage 2000 - �����������            
-- ����������� ��������-����������.
Tu_143  =  35;  -- Tu-143 (��-3) "����"           
Tu_141  =  36;  -- Tu-141 (��-2) "�����"

F_117   =  37;  -- F-117 ���������              
Su_39   =  38;  -- SU-39 ���������              
AN_26B  =  39;  -- AN-26B ������������              
AN_30M  =  40;  -- AN-30M ������������                  
E_2C    =  41;  -- E-2C Hawkeye �������� AWACS ��� AN_26B             
S_3A    =  42;  -- S-3A Viking �������� ���������               
AV_8B   =  43;  -- AV-8B Harrier �����������              
EA_6B   =  44;  -- EA-6B Prowler �������������������� ���������             
F_4E    =  45;  -- F-4E Phantom II �����������              
F_5E    =  46;  -- F-5E Tiger �����������               
C_17    =  47;  -- C-17 ������������ USA              
SU_17M4 =  48;  -- Cy-17M4 �����������              
MiG_29G  = 49;  -- MiG-29 Fulcrum ����������  
MiG_29C  = 50;  -- MiG-29 Fulcrum ����������  
Su_24MR  = 51;  -- Su-24MR Fencer   
F_16A    = 52;  -- F-16A Fighting Falcon    
FA_18C   = 53;  -- F/A-18C Hornet     
Su_25T   = 54;  -- Su-25 Frogfoot 
RQ_1A_Predator = 55;-- Predator UAV
TORNADO_IDS = 56;
Yak_40  =  57;  -- Yak-40 ������������              
A_10C   =  58;  -- A-10C
F_15E    =  59;  -- F-15E  
KC_135   =  60; -- KC-135 
L_39ZA   =  61;  -- �-39�� ������-������������� 
P_51B 	=  62;  -- P-51B
P_51D 	=  63;  -- P-51D-25-NA
P_51D_30_NA = 64; -- P-51D-30-NA
TF_51D 	=  65;  -- TF-51D
J_11A   =  66;  -- chinese licensed variant of base Su-27 
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
LastPlaneType = 150;--�������� �������� ��� ��������

-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--        Helicopters list.       ������ ����������
------------------------------------------------------------------------/
MI_8MT  =  1 + LastPlaneType;     -- M�-8��. ������/������� 
MI_24W  =  2 + LastPlaneType;   -- M�-24B. ������/������� 
MI_26   =  3 + LastPlaneType;   -- M�-26.  ������/������� 
KA_27   =  4 + LastPlaneType;   -- Ka-27.  ������/�������           
KA_50   =  5 + LastPlaneType;   -- Ka-50.  ������           
KA_52   =  6 + LastPlaneType;   -- Ka-52.  ������           
AH_64A  =  7 + LastPlaneType;   -- AH-64A Apache.         NATO              
AH_64D  =  8 + LastPlaneType;   -- AH-64D Apache Longbow. NATO              
CH_47D  =  9 + LastPlaneType;   -- CH-47D Chinook.        NATO              
CH_53E  = 10 + LastPlaneType;   -- CH-53E Super Stallion. NATO              
SH_60B  = 11 + LastPlaneType;   -- SH-60B Sea Hawk.       NATO              
UH_60A  = 12 + LastPlaneType;   -- UH-60A Night Hawk.     NATO              
AH_1W   = 13 + LastPlaneType;   -- AH-1W  Super Cobra.    NATO              
SH_3H   = 14 + LastPlaneType;   -- SH-3W  Sea King.     NATO              
Sea_Lynx= 15 + LastPlaneType;   -- Sea Lynx Mk88.     NATO              
AB_212  = 16 + LastPlaneType;   -- UH-1H.       NATO    
MI_28N  = 17 + LastPlaneType;   -- ��-28�
OH_58D  = 18 + LastPlaneType;   -- ������   NATO


-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

-- Air-to-Air Missiles.  ������ ������-������.
--                          0 - ����� empty 
R_550  =  1;   -- R550 Magic 2                  
MICA_T =  2;   -- MICA, IR                  
MICA_R =  3;   -- MICA, AR  
Super_530D =  4;   -- Super 530D                  
P_98   =  5;   -- ��� ����� P-98 == P-98R (AA-3  �Anab�)  
P_4R   =  6;   -- ��� ����� P-4R      (AA-5  'Ash')         
P_40R  =  7;   -- P-40R   (AA-6  'Acrid')   
--P_23R  =  8;   -- P-23R   (AA-7  'Apex')    
P_24R  =  9;   -- ��� ����� P-24R   (AA-7  'Apex')    
P_60   = 10;   -- ��� ����� P-60      (AA-8  'Aphid')��. ���    
P_33E  = 11;   -- P-33�  (AA-9  'Amos') ���.��������� 
P_27AE = 12;   -- P-27A� (AA-10 'Alamo')c�.���������    
P_27P  = 13;   -- P-27P  (AA-10 'Alamo')c�.���������    
P_27PE = 14;   -- P-27P� (AA-10 'Alamo')c�.���������    
P_27T  = 15;   -- P-27T  (AA-10 'Alamo')c�.���������    
P_27TE = 16;   -- P-27T� (AA-10 'Alamo')c�.���������    
P_27EM = 17;   -- P-27�M (AA-10 'Alamo')c�.���������    
P_73   = 18;   -- P-73   (AA-11 'Archer')��. ���    
P_77   = 19;   -- P-77 (PBB-AE) (AA-12)c�.���������             
P_37   = 20;   -- P-37                      

AIM_7  = 21;        -- AIM-7   'Sparrow'      
AIM_9  = 22;        -- AIM-9   'Sidewinder'   
AIM_54 = 23;        -- AIM-54  'Phoenix'    
AIM_120= 24;        -- AIM-120 'AMRAAM'   

--P_23T  = 25;        -- P-23T   (AA-7  'Apex')   
P_24T  = 26;        -- ��� ����� P-24T   (AA-7  'Apex')   
P_40T  = 27;        -- P-40T   (AA-6  'Acrid')    
SeaSparrow = 28;    -- Sea Sparrow 


-- Unguided rockets.   ������������� ���������� �������.
C_8CM  = 30;        -- C-8CM (� ������� �����)       
C_5    = 31;        -- C-5       
C_8    = 32;        -- C-8       
C_13   = 33;        -- C-13       
C_24   = 34;        -- C-24       
C_25   = 35;        -- C-25       
HYDRA_70 = 36;      -- HYDRA-70       
Zuni_127 = 37;      -- Zuni-127       
Zuni_127CM = 38;    -- Zuni-127CM (� ������� �����)       

-- Air-to-Surface Missiles. ������ ������-�����������.  

AGM_114K = 39; -- ��� AGM-114   
AGM_119= 40; -- Penguin, Norway   
X_22   = 41; -- X-22 Burya wing,anti-ship (AS-4'Kitchen')   
X_29TE = 42; -- X_29TE (AS-14  'Kedge' �������)     
X_23   = 43; -- X-23 Grom anti-radar(AS-7   'Kerry')    
X_28   = 44; -- X-28 anti-radar(AS-9   'Kyle')    
X_25ML = 45; -- X-25ML laser   (AS-10  'Karen')   
X_58   = 46; -- X-58  anti-radar(AS-11  'Kilter')   
X_25MP = 47; -- X-25MP anti-radar(AS-12  'Kegler')    
AT_6   = 48; -- AT_6 (9M114) radio-command anti-tank, STURM   
X_29L  = 49; -- X-29L laser    (AS-14  'Kedge')   
X_55   = 50; -- X-55  wing     (AS-15A 'Kent')    
X_65   = 51; -- X-65  wing     (AS-15B 'Kent')    
X_15   = 52; -- X-15 �nti-ship,ballistic(AS-16  'Kickback') 
X_31A  = 53; -- X-31A �nti-ship(AS-17  'Krypton')   
X_59M  = 54; -- X-59M Ovod     (AS-18   Kazoo)    
X_35   = 55; -- X-35           (AS-20  'Kayak') 
X_41   = 56; -- X-41 (unknown) �nti-ship    
Vikhr  = 57; -- 9M120 Vikhr laser (AT-12) {air-tank}    
Vikhr_M= 58; -- 9M120M  Vikhr-M (AT-X-16)laser{air-tank}  
AGM_114= 59; -- AGM-114 Hellfire laser            
AGM_45 = 60; -- AGM-45  'Shrike'  anti-radar      
AGM_65K= 61; -- AGM-65K 'Maverick'      
AGM_84A= 62; -- AGM-84  'Harpoon'     
AGM_84E= 63; -- AGM-84E 'SLAM'    
AGM_86 = 64; -- AGM-86  'CALCM'    wing   
AGM_88 = 65; -- AGM-88  'HARM'    anti-radar
Sea_Eagle = 66; -- Sea_Eagle  
SAV611 = 67; -- 4K60 ������������ �������� "�����"        ��� �����     
AGM_122= 68; -- AGM-122 'Sidearm' anti-radar  
AGM_123= 69; -- AGM-123 'Skipper' laser 
AGM_65E= 70; -- AGM-65E 
AGM_130= 71; -- AGM-130     wing    
ALARM  = 72; -- ALARM
X_23L  = 73; -- X-23L Grom laser (AS-7   'Kerry')   
X_25MR = 74; -- X-25MR TV     (AS-12  'Kegler')   
X_29T  = 75; -- X-29T  TV     (AS-14  'Kedge')    
X_31P  = 76; -- X-31� �nti-radar(AS-17  'Krypton')
AGM_65D= 77; -- AGM-65D  'Maverick'     
Kormoran=78; -- Kormoran AS 34      

-- Surface-to-Air Missiles and others. ������ �����������-������ � ������.

SM_2   = 79; -- SM-2    ��� TICONDEROGA
SA5B55 = 80; -- 5B55    ��������� �-300���
SA48H6E2=81; -- 48�6�2  ��������� �-300���
SA9M82 = 82; -- 9�82    ��������� �-300�
SA9M83 = 83; -- 9�83    ��������� �-300�
SA3M9M = 84; -- 3�9�    ��������� 2�12 ���
SA9M33 = 85; -- 9�33    ��������� 9�33 ���
SA9M31 = 86; -- 9�31    ��������� 9�31 ������-1
SA9M38M1=87; -- 9�38�1  ��������� 9�37 ���
SA9M333= 88; -- 9�333   ��������� 9�35 ������-10
SA9M330= 89; -- 9�330   ��������� ��� �1
SA9M311= 90; -- 9�311   ��������� 2C6� ��������
Igla_1E= 91; -- Igla-1E ��������� ���� ����
MIM_104= 92; -- MIM-104 ��������� Patriot
FIM_92C= 93; -- FIM_92C STINGER ��������� Avenger � ������.
--------------------------------------------------------------------------------
GRAD_9M22U  = 94; -- GRAD-RAKETA ���� ���� ������
URAGAN_9M27F = 179; -- URAGAN-RAKETA ���� ������
SMERCH_9M55K = 95; -- SMERCH-RAKETA ���� ����� ������ 
SMERCH_9M55F = 180; -- ���� ����� ������ �� (HE Rocket)
SA5B27       = 97; -- ������ �-� 5B27 ��� "��������"
HAWK_RAKETA  = 98; -- ������ ��� Hawk
ROLAND_R     = 99; -- ������ ROLAND

AIM_120C      = 106;

--------------------------------------------------------------------------------
-- Surface-to-Surface Missiles. ������ �����������-�����������
P_35   = 118; -- ������ ������������ ��������� ��������-�
P_500  = 119; -- ������ ������������ ��������� �������
P_700  = 120; -- ������ ������������ ��������� ������
P_15U  = 121; -- ������ ������������ ��������� ������
P_120  = 122; -- ������ ������������ ��������� �������
R_85   = 123; -- ������-������� ������������ ��������� ������
R_85U  = 124; -- ������-������� ������������ ��������� �������  
BGM_109B  = 125; -- ������ ������������ ��������� ��������
AGM_84S   = 126; -- ������ ������������ ��������� ������
MALUTKA   = 127; -- ������ ������� ���-1 � ���-1
KONKURS   = 128; -- ������ ������� ���-2
P_9M117   = 129; -- ������ � ���-3
TOW     = 130; -- ������ � �-2
M26 = 131; -- ���� � MLRS
AGM_154   = 132; -- AGM-154 JSOW
S_25L     = 133; -- S-25L
SCUD_RAKETA = 96; -- 
--------------------------------------------------------------------------------
wsType_Shell_SPPU = 134; --  ������ �����������. 20 �� 
--------------------------------------------------------------------------------
--  Added missiles
--Air-to-Air
AIM_9P = 135;   -- AIM-9P   'Sidewinder' rear_aspect IR missile 
AIM_9X = 136;   -- AIM-9X   'Sidewinder' perspective all aspect IR/UV missile 

MIM_72G  = 137;   -- M48 Chaparral missile, sidewinder-like
AGM_65H  = 138; -- new mavericks    
AGM_65G  = 139;
TGM_65G  = 140; -- training
TGM_65D  = 141; -- training
CATM_65K = 142; -- training


-- Air-to-air
CATM_9 = 143;   --

-- wsType ��� ����� ����
HYDRA_70_MK1   = 144;
HYDRA_70_MK5   = 145;
HYDRA_70_MK61  = 146;
HYDRA_70_M151  = 147;
HYDRA_70_M156  = 148;
HYDRA_70_WTU1B = 149;
HYDRA_70_M274  = 150;
HYDRA_70_M257  = 151;
HYDRA_70_M278  = 152;
P_9M133        = 153;
ATGM_Kornet    = P_9M133; -- 9M133
---------------------
TGM_65H 	   = 154;
---------------------
C_8OFP2        = 155;
---------------------
REFLEX         = 156; -- ATGM 9M119 Reflex T-80UD
SVIR	       = 157; -- ATGM 9M119 Svir T-72B
---------------------
C_8OM          = 158;
---------------------
HVAR 		   = 159;
TOW2           = 160; -- ATGM

-- Bombs. �����.  
Bomb_Other  =  0;  -- ���-�����-����� ����� (��� � ���� �� ������������)
BetAB_150DS =  1;  -- BetAB-150DS,
BetAB_250   =  2;  -- BetAB-250,
BetAB_500   =  3;  -- BetAB-500,
BetAB_500ShP=  4;  -- BetAB-500ShP      
FAB_100     =  5;  -- FAB-100,
FAB_250     =  6;  -- FAB-250,
FAB_500     =  7;  -- FAB-500
FAB_1000    =  8;  -- FAB-1000
FAB_1500  =  9;  -- FAB-1500
FAB_5000  = 10;  -- FAB-5000 ��� �����    
KAB_500     = 11;  -- KAB-500   
KAB_500Kr = 12;  -- KAB-500Kr,
KAB_500KrOD = 13;  -- KAB-500Kr-OD, 
KAB_1500Kr  = 14;  -- KAB-1500Kr  
ODAB_500PM  = 16;  -- ODAB-500 PM 
ODAB_250    = 17;  -- ODAB-250  ��� �����
RBK_250     = 18;  -- RBK-250,
RBK_250S  = 19;  -- RBK-250S,
RBK_500AO = 20;  -- RBK-500AO,
RBK_500SOAB = 21;  -- RBK-500SOAB 
Puma        = 22;  -- Puma
BL_755      = 23;  -- BL_755  
GluB        = 24;  -- Glubinaya Bomba             
NB_1        = 25;  -- Nuclear Bomb - 1 ��� �����              
NB_2        = 26;  -- Nuclear Bomb - 2              
Torpedo     = 27;  -- Torpedo             
XZAB_250    = 28;  -- XZAB-250,
XZAB_500    = 29;  -- XZAB-500    
Mk_81       = 30;  -- Mk-81
Mk_82       = 31;  -- Mk-82
Mk_83       = 32;  -- Mk-83
Mk_84       = 33;  -- Mk-84 
M_117       = 34;  -- M-117       
CBU_97      = 35;  -- CBU-97        
GBU_10      = 36;  -- GBU-10
GBU_11      = 37;  -- GBU-11
GBU_12      = 38;  -- GBU-12
GBU_16      = 39;  -- GBU-16
GBU_17      = 40;  -- GBU-40
GBU_24      = 41;  -- GBU-41
GBU_15      = 42;  -- GBU-15    
GBU_27      = 43;  -- GBU-27
GBU_22      = 44;  -- GBU-22
ROCKEYE     = 45;  -- �������� ���������

AGM_62      = 47;  -- AGM-62 Walley
GBU_28      = 48;  -- GBU-28      
GBU_29      = 49;  -- GBU-29
GBU_30      = 50;  -- GBU-30 JDAM

FAB_100P    = 53;  -- FAB-100�
FAB_250P    = 54;  -- FAB-250�
FAB_500P    = 55;  -- FAB-500�
FAB_500_3 = 56;  -- FAB-500 - 3 
MW_1      = 57;  -- MW-1 dispenser
PB_250      = 58;  -- PB-250  c ���������
Z_BAK_3   = 59;  -- ������������� ��� - 3 ��� 

Mk_50_Torpedo = 61;-- ������� Mk-60 
Durandal    = 62;  -- BLU_107 Durandal
SAB_100     = 63;  -- ������������� ���������
LUU_2B      = 64;  -- ������������� ��������� �� ������� SUU_25
AO_2_5RT    = 65;  -- ������������ ��� ����-2
PTAB_2_5KO  = 66;  -- ������������ ��� ����-2

-- 67 � 68 - PTAB_2_5RT_void � AO_2_5RT_void

BDU_33    = 69;
BDU_50LD  = 70;
BDU_50HD  = 71;
BDU_50LGB = 72;
BDU_56LD  = 73;
BDU_56LGB = 74;
MK_82AIR  = 75;
LUU_19    = 76; -- IR-������������� �����
CBU_87    = 77;
CBU_89    = 78;
MK_82SNAKEYE = 79;
LUU_2AB   = 80;
LUU_2BB   = 81;
LUU_1   = 82;
LUU_5   = 83;
LUU_6   = 84;


GBU_31      = 85;
GBU_38      = 86;
CBU_105     = 87;
CBU_103     = 88;
CBU_104     = 89;
AN_M64		= 90;

RBK_500U	= 91;

GBU_31_V_3B = 92;
CBU_52B = 93;

--       ���������� � ����. �������� ���������.
UB_13       = 1;    -- ��������� ����-��
UB_32_1     = 2;    -- ��������� ����-��
MBD_3       = 3;    -- �������� ��������� �� 3 �����
LAU_88    = 4;    -- �������� ��������� �� 3 MAVERICK
PTB_3000    = 5;    -- ��� �������� C�-24 �� 3000 �� �������
B_20        = 6;    -- ��������� ����-��
S_25_C      = 7;    -- ��������� C-25 c ������� 
LAU_10      = 8;    -- ��������� ����-��
LAU_61      = 9;    -- ��������� ����-��
F_15_PTB    =10;    -- ��� �������� F-15C    1600 �� �������
F_16_PTB_N1 =11;    -- ��� 1 �������� F-16   1120 �� �������
F_16_PTB_N2 =12;    -- ��� 2 �������� F-16    900 �� �������
F_18_PTB    =13;    -- ��� �������� F-18     1000 �� �������
MIG_23_PTB  =14;    -- ��� �������� MIG-23    640 �� �������
MIG_25_PTB  =15;    -- ��� �������� MIG-25   4370 �� �������
PTB_1150  =16;    -- ��� 1 �������� MIG-29  900 �� �������
PTB_1500  =17;    -- ��� 2 �������� MIG-29 1200 �� �������
SPPU_22   =18;    -- �������� ��������� ����-22
KINGAL    =19;    -- ����������� ��������� ��-39
UPK_23_25   =20;    -- �������� ��������� ���-23-25
MBD         =21;    -- �������� ��������� ���� 6-�������� 
MBD_4       =22;    -- �������� ��������� ���� 4-�������� 
TU_22_MBD   =23;    -- �������� ��������� ���� ��� ��-22�3 
S_25_PU     =24;    -- ��������� C-25 ��� ������
ALQ_131     =25;    -- ��������� ��� (���)
LANTIRN     =26;    -- ��������� ������.F-16
LANTIRN_F18 =27;    -- ��������� ������. F-18 
PAVETACK    =28;  -- ��������� ������. F-111  
SORBCIJA    =29;  -- ��������� ��� (��-27)  
SPS_141     =30;  -- ��������� ��� (������) 
PTB_B_1B    =31;  -- ��� �������� B-1B �� 14915 �� �������  
MBD_3_LAU_10=32;  -- MDB-3 & 3 LAU_10
MBD_3_LAU_61=33;  -- ��������� ����-�� MDB-3 & 3 LAU_61
AT_9M120  =34;    -- Vikhr (AT-12) {air-tank}   
AT_9M120M =35;    -- Vikhr-M (AT-X-16) {air-tank} 
F_5_PTB   =36;    -- ��� �������� F-5 1000 � �������
Sky_Shadow  =37;    -- ��������� ���, Tornado
PTB_F2_1500 =38;    -- ��� �������� Tornado �� 1500 �� �������
M2000_PTB   =39;    -- ��� �������� Mirage  �� 1000 �� �������
MBD_A10_2   =40;    -- �������� ��������� 2� ����� ��� A-10
F4_PTB_WING =41;    -- ��� �������� F-4 ���������
F4_PTB_FUZ  =42;    -- ��� �������� F-4 ����������
AGM_114_Pilon = 43; -- �������� ��������� 4� ��������
AT_6_9M114  =44;    -- SHTURM ��������� ���� Vikhr-M  
F4_PILON  =45;    -- �������� ��������� 2� ����� ��� F4
MER_L_P_60  = 46; -- �������� ��������� 2� ����� P_60 �����
MER_R_P_60  = 47; -- �������� ��������� 2� ����� P_60 ������
MER_TOW     = 48; -- �������� ��������� �� 4 TOW
MER_2_F_18  = 49; -- �������� ��������� �� 2, F-18
MER_9_B52   = 50; -- �������� ��������� �� 9, B-52
MER_12_B52  = 51; -- �������� ��������� �� 12, B-52
MBD_6_B52   = 52;   -- �������� ��������� �� 6, B-52
PTB_2000  = 53; -- ��������� ��� �� 2000 � ��� ��-34
PTB_800L_Wing = 54; -- ��������� ��� �� 800 � ��� Mig-23
PTB_S_3   = 55; -- ��������� ��� ��� S-3
PTB_367GAL  = 56; -- ��������� ��� �� 367 gal ��� F-14
SKY_SHADOW  = 57; -- ��������� ��� 
BOZ_100   = 58; -- ��������� c ���������
LANTIRN_F14 = 59; -- ��������� ������. F-14
FLIR_POD  = 60; -- ��������� ������. F-18
PTB_1150_29 = 61; -- ��������� ��� �� 1150 l ��� MiG-29
TANGAZH   = 62; -- ��������� ��� �������� 
EPHIR   = 63; -- ��������� ��� �������� 
SHPIL   = 64; -- ��������� ��� �������� 
FANTASM     = 65;   -- ��������� ������.
SmokeGenerator_red = 66;-- ������� ��������� (�������).
SmokeGeneratorAIM_red = 67;-- ������� ��������� (�������). AIM-9S
B_20CM       = 68;  -- ��������� ��������� ����-�� ������ B-20
Whiskey_Pete = 69;  -- ��������� ��������� ����-�� 2.75
SUU_25     = 70;  -- ��������� (�����) � �������������� ������� 
--71,72 is free, use if you want (duplicated F-18 fuel tanks removed)

AN_AAS_38_FLIR = 74; -- AN/AAS-38 FLIR
MBD_2_67U    = 76;  -- ���-2-67�
S_25L_AND_PU = 77;  -- �-25� + �� (�������� ��� ������)
AN_ASQ_173_LST_CAM = 78; -- AN/ASQ-173 LST/CAM
AKU_58     = 80;  -- AKU_58
KMGU_2       = 81;  -- KMGU-2
SmokeGenerator_green  = 82; -- ������� ��������� (�������).
SmokeGenerator_blue   = 83; -- ������� ��������� (�����).
SmokeGenerator_white  = 84; -- ������� ��������� (�����).
SmokeGenerator_yellow = 85; -- ������� ��������� (������).
SmokeGenerator_orange = 86; -- ������� ��������� (���������).
SmokeGeneratorAIM_green  = 87; -- ������� ��������� (�������). AIM-9S
SmokeGeneratorAIM_blue   = 88; -- ������� ��������� (�����). AIM-9S
SmokeGeneratorAIM_white  = 89; -- ������� ��������� (�����). AIM-9S
SmokeGeneratorAIM_yellow = 90; -- ������� ��������� (������). AIM-9S
SmokeGeneratorAIM_orange = 91; -- ������� ��������� (���������). AIM-9S
APU_68     = 92;  -- APU-68
APU_73     = 93;  -- APU-73
MPS_410    = 94;  -- MPS_410 �������������� ��������� �������
Kopyo    = 95;  -- ����� "�����" � ��������� ����������
APU_170    = 96;  -- ���-170
LAU_117    = 97;  -- LAU_117
B_8V20A      = 98;  -- B_8V20A
PTB_KA_50  = 99;  -- PTB KA-50
Shturm_9K114 = 100;
AN_AAQ_28_LITENING  = 101; -- AN/AAQ-28 LITENING
TER_LS     = 102; -- Triple ejector rack
TK600    = 103; -- ��������� ���
TRAVEL_POD   = 104;

-- �����
-- �� LAU_68
LAU_68_HYDRA_70_MK1   = 105;
LAU_68_HYDRA_70_MK5   = 106;
LAU_68_HYDRA_70_MK61  = 107;
LAU_68_HYDRA_70_M151  = 108;
LAU_68_HYDRA_70_M156  = 109;
LAU_68_HYDRA_70_WTU1B = 110;
LAU_68_HYDRA_70_M274  = 111;
LAU_68_HYDRA_70_M257  = 112;
LAU_68_HYDRA_70_M278  = 113;
-- �� LAU_131
LAU_131_HYDRA_70_MK1  = 114;
LAU_131_HYDRA_70_MK5  = 115;
LAU_131_HYDRA_70_MK61 = 116;
LAU_131_HYDRA_70_M151 = 117;
LAU_131_HYDRA_70_M156 = 118;
LAU_131_HYDRA_70_WTU1B  = 119;
LAU_131_HYDRA_70_M274 = 120;
LAU_131_HYDRA_70_M257 = 121;
LAU_131_HYDRA_70_M278 = 122;

-- 3* SUU_25 (�� TER)
SUU_25x3        = 123;

-- �� ������� LAU_68 (�� TER)
LAU_68x3_HYDRA_70_MK1 = 124;
LAU_68x3_HYDRA_70_MK5 = 125;
LAU_68x3_HYDRA_70_MK61  = 126;
LAU_68x3_HYDRA_70_M151  = 127;
LAU_68x3_HYDRA_70_M156  = 128;
LAU_68x3_HYDRA_70_WTU1B = 129;
LAU_68x3_HYDRA_70_M274  = 130;
LAU_68x3_HYDRA_70_M257  = 131;
LAU_68x3_HYDRA_70_M278  = 132;

-- �� ������� LAU_131 (�� TER)
LAU_131x3_HYDRA_70_MK1  = 133;
LAU_131x3_HYDRA_70_MK5  = 134;
LAU_131x3_HYDRA_70_MK61 = 135;
LAU_131x3_HYDRA_70_M151 = 136;
LAU_131x3_HYDRA_70_M156 = 137;
LAU_131x3_HYDRA_70_WTU1B= 138;
LAU_131x3_HYDRA_70_M274 = 139;
LAU_131x3_HYDRA_70_M257 = 140;
LAU_131x3_HYDRA_70_M278 = 141;

ALQ_184         = 142;
LAU_68          = 143;
LAU_131         = 144;
OH_58_BRAUNING  = 145; 
LAU_131WP       = 146; 
M279_AGM114     = 147;
B_8V20A_WP      = 148;
B_8V20A_OFP2    = 149;
B_8V20A_OM      = 150;
B_8M1_OFP2      = 151;

DROP_TANK_75GAL = 152;

M134_L		 = 160;
M134_R		 = 161;

XM_158_HYDRA_70_MK1		= 162;
XM_158_HYDRA_70_MK5		= 163;
XM_158_HYDRA_70_M151	= 164;
XM_158_HYDRA_70_M156	= 165;
XM_158_HYDRA_70_M274	= 166;
XM_158_HYDRA_70_M257	= 167;

M261_HYDRA_70_M151		= 168;
M261_HYDRA_70_M156		= 169;

GUV_YakB_GSHP		     = 170;
GUV_VOG				     = 171;
HWAR_SMOKE_GENERATOR     = 172;

M134_SIDE_L		 = 174;
M134_SIDE_R		 = 175;
M60_SIDE_L		 = 176;
M60_SIDE_R		 = 177;
BRU_42_HS 		 = 178;

KORD_12_7		 = 183;
PKT_7_62		 = 184;

----------------------------------------------------------------------/
-- �������
----------------------------------------------------------------------/

Kuznecow  = 1;  -- ����������� ������� ��������
VINSON      = 2;  -- ��������� VINSON
MOSCOW      = 3;  -- ������� "������"
GROZNY      = 4;  -- P.������� "�������"
wsType_GenericCivShip = 5;
--ELNYA     = 5;  -- ������ �����
wsType_GenericLightArmoredShip	= 6;
--KATER     = 6;  -- �������� �����
--AKVAMAREN = 7;  -- ��� ���������  Natya (NAT�-���)
AZOV    = 8;  -- ��� ���� Kara
BOBRUISK  = 9;  -- ��� �������� Ropucha
BORA    = 10;  -- ���� ���� Sivuch
ALBATROS  = 11;  -- ��� ��������� Grisha V
AMETYST   = 12;  -- ��� ������� Grisha II
OREL    = 13;  -- ���� ���� Krivak III
REZKY   = 14;  -- ���� ������  Krivak II
MOLNIYA   = 15;  -- �. ����� ������ Tarantul III
--MURENA    = 16;  -- ��� ������ Tsaplya
PERRY   = 17;  -- ������ Oliver Perry
OSA     = 18;  -- �. ����� ���  Osa
SKORY   = 19;  -- ��� ������  Kashin
SPRUANCE  = 20;  -- ������� Spruance    
TICONDEROGA = 21;  -- �. ������� Ticonderoga  
--TK      = 22;  -- ��������� ����� 
--wsType_GenericSubmarine	= 23; -- Temporary
KILO    = 23;  -- �� ���������� Kilo
TANGO     = 24;  -- �� ���  Tango
VETER   = 25;  -- �. ����� �����  Nanuchka III
--ZWEZDNY     = 26;  -- ����������� �����
--YASTREBOW = 27;  -- ������������ �������
NEUSTRASH = 28;  -- ������������ �������
--BARGE_WITH_SAND = 29; 
--BARGE_WITHOUT_SAND = 30;
-- ��� ���������� ������� �������������� LastShipType !!!
LastShipType = NEUSTRASH;

----------------------------------------------------------------------/
-- ������� (�����)
----------------------------------------------------------------------/

wsType_Test4    = 200;  -- ����� �� �����

----------------------------------------------------------------------/
-- ������ �������� ��������  
----------------------------------------------------------------------/
-- ������� ���
----------------------------------------------------------------------/

EWR_1L13      = 1;  -- ����� �������� ����������� 1L13
EWR_55G6      = 2;  -- ����� �������� ����������� 55�6 
KP_54K6       = 3;  -- �� 54K6 ��������� �����
V_40B6M       = 4;  -- track radar                   
V_40B6MD      = 5;  -- search radar
RLS_5H63C     = 6;  -- track radar 
RLO_64H6E     = 7;  -- search radar
PU_5P85C      = 8;  -- launcher
PU_5P85D      = 9;  -- launcher
RLS_9C32_1      = 10; -- track radar 
RLO_9C15MT      = 11; -- search radar
RLO_9C19M2      = 12; -- search radar
S300V_9A82      = 13; -- launcher
S300V_9A83      = 14; -- launcher
S300V_9A84      = 15; -- launcher
S300V_9A85      = 16; -- launcher
BUK_9C470M1     = 17; -- ��
BUK_9C18M1      = 18; -- search radar
BUK_PU        = 19; -- launcher 
BUK_LL        = 20; -- loader/launcher 
KUB_1C91      = 21; -- search and track radar (str)
KUB_2P25      = 22; -- launcher 
OSA_9A33BM3     = 23; -- search radar 
OSA_9T217     = 24; -- loader 
Strela_9K31     = 25; -- launcher 
Strela_9K35     = 26; -- launcher (ln)
Radar_Dog_Ear   = 27; -- search radar  
Tor_        = 28; -- str, ln 
Tunguska_     = 29; -- str, ln
Shilka_       = 30; -- str, ln
Roland_       = 31; -- str, ln  
Roland_Search_Radar = 32; -- search radar
Avenger_      = 33; -- ln
Patr_AN_MPQ_53_P  = 34; -- str
Patr_KP       = 36; -- ��������� ����� ��� "��������"
Patriot_      = 37; -- ln
Gepard_       = 38; -- str, ln 
Hawk_Search_Radar   = 39; -- search radar
Hawk_Track_Radar    = 40; -- track radar 
Hawk_               = 41; -- ln
Hawk_CWAR_Radar		= 42;
Hawk_CV				= 43;
--Stinger_            = 44; -- ln
--KP_S300V_9C457      = 45; -- ����� ������� ���������� ������� �300 �
wsTypeVulkan        = 46; -- ln
wsType_GenericAAA		= 47; -- Temporary
ZU_23               = 47; -- ����� ����������� ��-23
ZU_23_OKOP          = 48; -- ����������� ��-23 � ����������
ZU_23_URAL          = 49; -- ��������� ��-23 �� �����
wsType_Generic_IR_SAM	= 50; -- Temporary
M48_Chaparral       = 50; -- ������ ������-1
M6Linebacker        = 51; -- M6 Linebacker

HumanTypeStart      = 52; -- ����� ����� ��� ������� � ��������
IglaRUS_1           = 52; -- ������� 
IglaRUS_2           = 53; -- ������� ����
IglaGRG_1           = 54; -- �������
IglaGRG_2           = 55; -- ������� ����
Stinger_manpad		= 56; -- ������������ ����������
--StingerUSA_1        = 56; -- �������
StingerUSA_2        = 57; -- ������� ����
--StingerIZR_1        = 58; -- �����������
StingerIZR_2        = 59; -- ����������� ����
--StingerGRG_1		= 60; -- �������
--StingerGRG_2		= 61; -- ������� ����
IglaINS_1			= 62;
HumanTypeEnd        = 62; -- ����� ����� ��� ������� � ��������

ZU_23_insurgent     = 70;   -- ZU-23 insurgent
ZU_23_insurgent_okop = 71;  -- ZU-23 insurgent
ZU_23_insurgent_ural = 72;  -- ZU-23 insurgent
SA3_TR              = 73;   -- S-125
SA3_LN              = 74;   -- S-125
SA3_SR              = 75;   -- S-125

-- ��� ���������� ������� �������������� LastSAMType !!!
LastSAMType         = SA2_SR; 

----------------------------------------------------------------------/
-- �������� �������
----------------------------------------------------------------------/
wsType_GenericSAU 	= 1; -- Temporary
--wsTypeSAUmsta   = 1;  
--wsTypeSAUakacia   = 2;  
--wsTypeSAU_2C9   = 3;
wsTypeTMZ5      = 4;  
wsTypeTZ10      = 5;
wsType_GenericVehicle	= 6;
--wsTypeUralApa   = 6;
wsType_GenericIFV	= 7; --Temporary
--wsTypeBMD1      = 7;  
--wsTypeBMP1      = 8;  
--wsTypeBMP2      = 9;  
wsType_GenericAPC	= 10; -- Temporary
--wsTypeBRDM2     = 10; 
--wsTypeBTR70     = 11; 
--wsTypeGrad      = 12;  
--wsTypeM818        = 13; -- ����� M-818
wsType_Hummer    = 14; -- Temporary
--wsTypeLAV25     = 15; 
wsType_GenericTank	= 16;
--wsTypeLeopard2    = 16; 
--wsTypeAAV7       = 17; 
--wsTypeM109        = 18; 
--wsTypeM113        = 19; 
--wsTypeM113G       = 20; 
--wsTypeAbrams      = 21; 
--wsTypeMarder      = 22; 
--wsTypeBeregSAU    = 23; 
--wsTypeBeregRLS    = 24; 
wsTypeMAZelektro  = 25; 
wsTypeMAZkaraul   = 26; 
wsTypeMAZobsch    = 27; 
wsTypeMAZstol   = 28; 
--wsTypeSmerch    = 29; 
--wsTypeATZ60     = 30; 
--wsTypeRLS_PRW11   = 31;
wsTypeRLS_RSP7    = 32; 
--wsTypeReis        = 33; -- ������ �������� ���� 
wsTypeRLS37       = 34; -- ���-37
--wsTypeT80         = 35; 
--wsTypeTiagach     = 36; -- ����� ��� ���������  
--wsTypeTPZ       = 37; 
wsTypeUAZ469    = 38; 
--wsTypeUragan    = 39; 
wsTypeUral375     = 40; 
wsTypeUral375PBU    = 41; 
--wsTypeZapros        = 43; 
wsTypeZIL135        = 44; 
wsTypeElektrovoz  = 45; -- ����������
wsTypeBus     = 46; -- �������
wsTypeVAZ     = 47; -- �������� ����������
wsTypeTeplowoz    = 48; -- ��������   
wsTypeTrolebus    = 49; -- ����������   
wsTypeWCisternaBLUE   = 50; -- �����-�������� 
wsTypeWCisternaYELLOW   = 98; -- �����-��������   
wsTypeWGruz     = 51; -- ����� ��������   
wsTypeWGruzOtkr   = 52; -- ����� ��������   
wsTypeWagonPlatforma= 53; -- �����-���������    
wsTypeWagonPass   = 54; -- ����� ������������
--wsTypeRadioSt   = 55; -- �������� ����� ����
wsTypeKAMAZ_Fire  = 56; -- �������� �����
wsTypeKAMAZ_Tent  = 57; -- ����� � ������
wsTypeLAZ_695   = 58; -- �������� ����� ����
--wsType2C1       = 59; -- C��
--wsTypeBMP3      = 60; -- ���-3
--wsTypeM2Bradley   = 61; -- ���
--wsTypeMCV80     = 62; -- ���
wsType_GenericMLRS      = 63; -- ����
--wsTypeM_60      = 64; -- ���� �-60
--wsTypeLeo1      = 65; -- ���� Leo1
--wsTypeBTR_D     = 66; -- ���-�
wsTypeGAZ_66    = 67; -- GAZ-66
wsTypeGAZ_3307    = 68; -- GAZ-3307
wsTypeGAZ_3308    = 69; -- GAZ-3308
wsTypeMAZ_6303    = 70; -- MAZ-6303
wsTypeZIL_4334    = 71; -- ZIL-4334
--wsTypePredator_GCS  = 72; --�� ��� UAV Predator
--wsTypePredator_TrojanSpirit  = 73;--������� ����� ��� UAV Predator
--wsTypeZIL_SKP_11    = 74; --���-11 ����������� �� ��� ����������� �������� � ����� ����������
wsTypeURAL_4320T    = 75; --�������� ����-4320 � ����������� �������
--wsTypeURAL_4320_31  = 76; --�������� ����-4320-31 � �������������� �������
--wsTypeURAL_ATsP_6   = 77; --�������� ������ ���� ���-6
--wsTypeZIL_APA_80    = 78; --����������� �������� ������� ��� ���-80
wsTypeZIL_131_KUNG  = 79; --�������� ���-131 ����
wsType_Stryker		= 80;
--wsTypeM1126_Stryker_ICV  = 80;  --��� M1126 Stryker ICV
--wsTypeM1128_Stryker_MGS  = 81;  --��� M1128 Stryker MGS
--wsTypeM1134_Stryker_ATGM  = 82; --��� M1134 Stryker ATGM
--wsTypeMTLB  = 83;
--wsTypeBTR80 = 84;
--wsTypeT72 = 85;
--wsTypeT55 = 86;
--wsTypeM1043 = 87; -- ������ + M2
--wsTypeM1045 = 88; -- ������ + TOW
--wsTypeLeClerc = 89; 
wsType_GenericInfantry	= 90;
--wsTypeRPG = 90; 
--wsTypeAutogun = 91; 
--wsTypeHEMTT_M978 = 92; 
--wsTypeSoldier_AK = 93;   
--wsTypeSoldier_RPG = 94;   
--wsTypeBOMAN = 95;
wsType_GenericFort = 96;
--wsTypeSandbox = 96;
--wsTypeBunker = 97;
-- ��� ���������� ������� �������������� LastTankType
--LastTankType = wsTypeBunker;--  ����� ���������� Tank-�


wsTypeSteamLocomotive = 99;

----------------------------------------------------------------------/
-- ������ �������� �������� (�����) 
----------------------------------------------------------------------/

--*************************************************
-- ��������� ��� ��������� �� ��������� !!! �� ������ � Level 1,2,3,4--*
 wsRadarAir           = 101;--
 wsRadarLongRange     = 102;--
 wsRadarMidRange      = 103;--
 wsRadarShrtRange     = 104;--
 wsRadarEWS       = 105;--
 wsRadarEngagement    = 106;--
 wsTypeLauncher     = 107;
 wsTypeComandPost     = 108;
 wsRadarOptical       = 109;
 wsRadarAWACS     = 110;
 wsRadarActiveHoming  = 111;


--    �����
Gun__ = 241;        -- �������� ����������� �����
Gun__1= 242;        -- �������� ����������� �����
--    �������� ��������� � ���������� 
--    wsType_Weapon, wsType_Missile(Bomb), wsType_Container
MBD_FAB_100       = 1;  -- MDB & 6 FAB-100
MBD_FAB_250       = 2;  -- MDB & 6 FAB-250
MBD_FAB_500       = 3;  -- MDB & 6 FAB-500
MBD_BETAB_250     = 4;  -- MDB & 6 BETAB-250
MBD_ODAB          = 5;  -- MDB & 6 ODAB
MBD_PB_250        = 6;  -- MDB & 6 PB-250
MBD_RBK_250       = 7;  -- MDB & 6 RBK-250
MBD_RBK_500AO     = 8;  -- MDB & 6 RBK-500AO
MBD_RBK_500SOAB   = 9;  -- MDB & 6 RBK-500SOAB
MBD_ZAB           = 10; -- MDB & 6 ZAB
MBD_CBU_97        = 11; -- MDB & 6 CBU-97
MBD_M_117         = 12; -- MDB & 6 M-117AB
MBD_MK_81         = 13; -- MDB & 6 MK-81
MBD_MK_82         = 14; -- MDB & 6 MK-84
MBD_Rockeye       = 15; -- MDB & 6 Rockeye
MBD_3_FAB_100     = 16; -- MDB-3 & 3 FAB-100
MBD_3_FAB_250     = 17; -- MDB-3 & 3 FAB-250
MBD_3_FAB_500     = 18; -- MDB-3 & 3 FAB-500
MBD_3_BETAB_250   = 19; -- MDB-3 & 3 BETAB-250
MBD_3_ODAB        = 20; -- MDB-3 & 3 ODAB
MBD_3_PB_250      = 21; -- MDB-3 & 3 PB-250
MBD_3_RBK_250     = 22; -- MDB-3 & 3 RBK-250
MBD_3_RBK_500AO   = 23; -- MDB-3 & 3 RBK-500AO
MBD_3_RBK_500SOAB = 24; -- MDB-3 & 3 RBK-500SOAB
MBD_3_ZAB         = 25; -- MDB-3 & 3 ZAB
MBD_3_CBU_97      = 26; -- MDB-3 & 3 CBU-97
MBD_3_M_117       = 27; -- MDB-3 & 3 M-117AB
MBD_3_MK_81       = 28; -- MDB-3 & 3 MK-81
MBD_3_MK_82       = 29; -- MDB-3 & 3 MK-84
MBD_3_Rockeye     = 30; -- MDB-3 & 3 Rockeye
MBD_3_GBU_16      = 31; -- MDB-3 & 3 GBU_16
MBD_4_FAB_100     = 32; -- MDB-4 & 4 FAB-100
LAU_88_AGM_65K    = 33; -- LAU_88 & 3 AGM-65K
TU_22_FAB_100     = 34; -- TU-22M3-MBD & 9 FAB-100
TU_22_FAB_250     = 35; -- TU-22M3-MBD & 9 FAB-250
TU_22_BETAB_250   = 36; -- TU-22M3-MBD & 9 BETAB-250
TU_22_PB_250      = 37; -- TU-22M3-MBD & 9 PB-250
TU_22_RBK_250     = 38; -- TU-22M3-MBD & 9 RBK_250
TU_22_FAB_500     = 39; -- TU-22M3-MBD & 6 FAB-500
TU_22_BETAB_500   = 40; -- TU-22M3-MBD & 6 BETAB_500
TU_22_BETAB_500SP = 41; -- TU-22M3-MBD & 6 BETAB_500SP
TU_22_ODAB        = 42; -- TU-22M3-MBD & 6 ODAB
TU_22_RBK_500AO   = 43; -- TU-22M3-MBD & 6 RBK_500AO
TU_22_RBK_500SOAB = 44; -- TU-22M3-MBD & 6 RBK_500SOAB
TU_22_ZAB     = 45; -- TU-22M3-MBD & 6 ZAB
VICHR       = 46; -- Vikhr (AT-12) {air-tank}   
VICHR_M         = 47; -- Vikhr-M (AT-X-16) {air-tank} 
LAU_88_AGM_65D    = 48; -- LAU_88 & 3 AGM-65D
LAU_88_AGM_65E    = 49; -- LAU_88 & 3 AGM-65E
MBD_A10_2_AIM_9   = 50; -- MBD_A10_2 & 2 AIM_9
MBD_F2_2_Mk_82    = 51; -- MBD F2_2  & 2 Mk_82
MBD_F2_2_Mk_83    = 52; -- MBD F2_2  & 2 Mk_83
MBD_F2_2_Puma   = 53; -- MBD F2_2  & 2 Puma
MBD_F2_2_BL_755   = 54; -- MBD F2_2  & 2 BL_755
MBD_F2_2_ROCKEYE  = 55; -- MBD F2_2  & 2 ROCKEYE
MBD_F2_2_ALARM    = 56; -- MBD F2_2  & 2 ALARM
MBD_3_GBU_22      = 57; -- MDB-3 & 3 GBU_22
AGM_114_Pilon_4   = 58; -- AGM_114_Pilon & 4 AGM_114
AGM_114K_Pilon_4  = 59; -- AGM_114_Pilon & 4 AGM_114K
SHTURM          = 60; -- SHTURM 
MER_AIM_9_2       = 61; -- F4_PILON & 2 AIM-9
MER_L_P_60_2      = 62; -- MER_L_P_60 & 2 P-60
MER_R_P_60_2      = 63; -- MER_R_P_60 & 2 P-60
MER_TOW_4       = 64; -- MER_TOW & 4 TOW
LAU_88_AGM_65K_2_LEFT = 65; -- LAU_88 & 2(6) AGM_65K (left)
LAU_88_AGM_65D_2_LEFT = 66; -- LAU_88 & 2(6) AGM_65D (left)
MER_6_AGM_86C     = 67; -- MBD_B52_6 & 6 AGM_86C
MBD_FAB_250_2     = 68; -- MDB & 2(6) FAB_250
MBD_RBK_250_2     = 69; -- MDB & 2(6) RBK_250
MBD_BetAB_250_2   = 70; -- MDB & 2(6) BetAB_250
TU_22_FAB_1500_2  = 71; -- TU-22M3-MBD & 2(9) FAB-1500
MBD_3_BetAB_500   = 72; -- MDB-3 & 3 BetAB_500
MER_2_F_18_CBU_97 = 73; -- MER_2_F_18 & 2 CBU_97
MER_12_B52_Mk_82  = 74; -- MER_12_B52 & 12 Mk_82
MER_6_BLU_107   = 75; -- MDB & 6 BLU-107
MER_12_B52_M_117  = 76; -- MER_12_B52 & 12 M_117
MER_9_B52_CBU_97  = 77; -- MER_9_B52 & 9 CBU_97
MER_9_B52_Mk_84   = 78; -- MER_9_B52 & 9 Mk_84
MER_9_B52_Rockeye = 79; -- MER_9_B52 & 9 Rockeye
MBD_4_RBK_250     = 80; -- MDB-4 & 4 RBK_250
MBD_4_FAB_250     = 81; -- MDB-4 & 4 FAB_250
MER_6_2_PB_250    = 82; -- MBD & 2 PB_250
MER_6_4_PB_250    = 83; -- MBD & 4 PB_250
MER_6_4_FAB_250   = 84; -- MBD & 4 FAB_250
SUU_25_8_LUU_2    = 85; -- SUU_25 & 8 LUU_2B
APU_6_VICHR_M   = 86; -- APU_6_VIKHR & 6 Vikhr_M
S_25L_PU      = 87; -- S_25L & PU
MBD_2_67U_FAB_100 = 88; -- MBD_2_67U & FAB_100
AKU_58_X_58     = 91; -- AKU_58 & X_58
AKU_58_X_29T    = 92; -- AKU_58 & X_29T
AKU_58_X_29L    = 93; -- AKU_58 & X_29L
KMGU_2_AO_2_5RT   = 94; -- KMGU-2 & AO_2_5RT
KMGU_2_PTAB_2_5KO = 95; -- KMGU-2 & PTAB_2_5KO
AKU_58_X_31A    = 96; -- AKU-58 & X-31A
AKU_58_X_31P    = 97; -- AKU-58 & X-31P
AKU_58_X_35     = 98; -- AKU-58 & X-35
APU_68_X_25ML   = 99; -- APU-68 & X-25ML
APU_68_X_25MP     = 100; -- APU-68 & X-25MP
APU_68_C_24     = 101; -- APU-68 & C-24
APU_73_P_73     = 102; -- APU-73 & R-73
APU_170_P_77    = 103; -- APU-170 & R-77
LAU_88_AGM_65E_2_LEFT  = 104; -- LAU_88 & 2(6) AGM_65E (left)
LAU_88_AGM_65K_2_RIGHT = 105; -- LAU_88 & 2(6) AGM_65K (right)
LAU_88_AGM_65D_2_RIGHT = 106; -- LAU_88 & 2(6) AGM_65D (right)
LAU_88_AGM_65E_2_RIGHT = 107; -- LAU_88 & 2(6) AGM_65E (right)
LAU_117_AGM_65K   = 108; -- LAU_117 & AGM_65K
LAU_117_AGM_65D   = 109; -- LAU_117 & AGM_65D
LAU_117_AGM_65E   = 110; -- LAU_117 & AGM_65E



-- A-10C
TER_3_BDU_33    	 = 114;
LAU_117_AGM_65H  	 = 125; -- LAU_117 & AGM_65H
LAU_117_AGM_65G 	 = 126; -- LAU_117 & AGM_65G
TER_3_GBU_12 		 = 127 ; -- BRU-42 3*GBU_12
LAU_105_1_AIM_9M_L   = 128 ;
LAU_105_2_CATM_9M    = 129 ;
LAU_105_1_CATM_9M_L  = 130 ;
TER_3_MK82AIR     	 = 131 ;
TER_FREE    		 = 132;
LAU_105_FREE 		 = 133;
LAU_88_AGM_65H 		 = 134;
LAU_88_AGM_65H_2_L 	 = 135 ;
LAU_88_AGM_65H_2_R 	 = 136 ;
LAU_88_AGM_65H_3 	 = 137 ;
LAU_117_TGM_65D 	 = 138 ;
LAU_117_TGM_65G 	 = 139 ;
LAU_117_TGM_65H 	 = 140 ;
LAU_117_CATM_65K 	 = 141 ;
LAU_105_1_AIM_9M_R   = 142 ;
LAU_105_1_CATM_9M_R  = 143 ;
TER_3_SUU_25_8_LUU_2 = 144 ;
LAU_88_AGM_65D_ONE   = 145 ;
APU_68_X_25MR  	     = 170 ;
AKU_58_X_59  	     = 171 ;