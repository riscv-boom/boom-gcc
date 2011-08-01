------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                                  O P T                                   --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--          Copyright (C) 1992-2010, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

with Debug;
with Gnatvsn; use Gnatvsn;
with System;  use System;
with Tree_IO; use Tree_IO;

package body Opt is

   SU : constant := Storage_Unit;
   --  Shorthand for System.Storage_Unit

   ---------------
   -- ALFA_Mode --
   ---------------

   function ALFA_Mode return Boolean is
   begin
      return ALFA_Through_SPARK_Mode or else ALFA_Through_Why_Mode;
   end ALFA_Mode;

   -----------------------------
   -- ALFA_Through_SPARK_Mode --
   -----------------------------

   function ALFA_Through_SPARK_Mode return Boolean is
   begin
      return Debug.Debug_Flag_Dot_EE;
   end ALFA_Through_SPARK_Mode;

   ---------------------------
   -- ALFA_Through_Why_Mode --
   ---------------------------

   function ALFA_Through_Why_Mode return Boolean is
   begin
      return Debug.Debug_Flag_Dot_FF;
   end ALFA_Through_Why_Mode;

   ---------------------
   -- Formal_Language --
   ---------------------

   function Formal_Language return String is
   begin
      pragma Assert (Formal_Verification_Mode);
      if ALFA_Mode then
         return "alfa";
      elsif SPARK_Mode then
         return "spark";
      else
         pragma Assert (False);
         return "";  --  unreachable
      end if;
   end Formal_Language;

   ------------------------------
   -- Formal_Verification_Mode --
   ------------------------------

   function Formal_Verification_Mode return Boolean is
   begin
      return ALFA_Mode or else SPARK_Mode;
   end Formal_Verification_Mode;

   ----------------------------------
   -- Register_Opt_Config_Switches --
   ----------------------------------

   procedure Register_Opt_Config_Switches is
   begin
      Ada_Version_Config                    := Ada_Version;
      Ada_Version_Explicit_Config           := Ada_Version_Explicit;
      Assertions_Enabled_Config             := Assertions_Enabled;
      Assume_No_Invalid_Values_Config       := Assume_No_Invalid_Values;
      Check_Policy_List_Config              := Check_Policy_List;
      Debug_Pragmas_Enabled_Config          := Debug_Pragmas_Enabled;
      Default_Pool_Config                   := Default_Pool;
      Dynamic_Elaboration_Checks_Config     := Dynamic_Elaboration_Checks;
      Exception_Locations_Suppressed_Config := Exception_Locations_Suppressed;
      Extensions_Allowed_Config             := Extensions_Allowed;
      External_Name_Exp_Casing_Config       := External_Name_Exp_Casing;
      External_Name_Imp_Casing_Config       := External_Name_Imp_Casing;
      Fast_Math_Config                      := Fast_Math;
      Init_Or_Norm_Scalars_Config           := Init_Or_Norm_Scalars;
      Initialize_Scalars_Config             := Initialize_Scalars;
      Optimize_Alignment_Config             := Optimize_Alignment;
      Persistent_BSS_Mode_Config            := Persistent_BSS_Mode;
      Polling_Required_Config               := Polling_Required;
      Short_Descriptors_Config              := Short_Descriptors;
      Use_VADS_Size_Config                  := Use_VADS_Size;

      --  Reset the indication that Optimize_Alignment was set locally, since
      --  if we had a pragma in the config file, it would set this flag True,
      --  but that's not a local setting.

      Optimize_Alignment_Local := False;
   end Register_Opt_Config_Switches;

   ---------------------------------
   -- Restore_Opt_Config_Switches --
   ---------------------------------

   procedure Restore_Opt_Config_Switches (Save : Config_Switches_Type) is
   begin
      Ada_Version                    := Save.Ada_Version;
      Ada_Version_Explicit           := Save.Ada_Version_Explicit;
      Assertions_Enabled             := Save.Assertions_Enabled;
      Assume_No_Invalid_Values       := Save.Assume_No_Invalid_Values;
      Check_Policy_List              := Save.Check_Policy_List;
      Debug_Pragmas_Enabled          := Save.Debug_Pragmas_Enabled;
      Default_Pool                   := Save.Default_Pool;
      Dynamic_Elaboration_Checks     := Save.Dynamic_Elaboration_Checks;
      Exception_Locations_Suppressed := Save.Exception_Locations_Suppressed;
      Extensions_Allowed             := Save.Extensions_Allowed;
      External_Name_Exp_Casing       := Save.External_Name_Exp_Casing;
      External_Name_Imp_Casing       := Save.External_Name_Imp_Casing;
      Fast_Math                      := Save.Fast_Math;
      Init_Or_Norm_Scalars           := Save.Init_Or_Norm_Scalars;
      Initialize_Scalars             := Save.Initialize_Scalars;
      Optimize_Alignment             := Save.Optimize_Alignment;
      Optimize_Alignment_Local       := Save.Optimize_Alignment_Local;
      Persistent_BSS_Mode            := Save.Persistent_BSS_Mode;
      Polling_Required               := Save.Polling_Required;
      Short_Descriptors              := Save.Short_Descriptors;
      Use_VADS_Size                  := Save.Use_VADS_Size;
   end Restore_Opt_Config_Switches;

   ------------------------------
   -- Save_Opt_Config_Switches --
   ------------------------------

   procedure Save_Opt_Config_Switches (Save : out Config_Switches_Type) is
   begin
      Save.Ada_Version                    := Ada_Version;
      Save.Ada_Version_Explicit           := Ada_Version_Explicit;
      Save.Assertions_Enabled             := Assertions_Enabled;
      Save.Assume_No_Invalid_Values       := Assume_No_Invalid_Values;
      Save.Check_Policy_List              := Check_Policy_List;
      Save.Debug_Pragmas_Enabled          := Debug_Pragmas_Enabled;
      Save.Default_Pool                   := Default_Pool;
      Save.Dynamic_Elaboration_Checks     := Dynamic_Elaboration_Checks;
      Save.Exception_Locations_Suppressed := Exception_Locations_Suppressed;
      Save.Extensions_Allowed             := Extensions_Allowed;
      Save.External_Name_Exp_Casing       := External_Name_Exp_Casing;
      Save.External_Name_Imp_Casing       := External_Name_Imp_Casing;
      Save.Fast_Math                      := Fast_Math;
      Save.Init_Or_Norm_Scalars           := Init_Or_Norm_Scalars;
      Save.Initialize_Scalars             := Initialize_Scalars;
      Save.Optimize_Alignment             := Optimize_Alignment;
      Save.Optimize_Alignment_Local       := Optimize_Alignment_Local;
      Save.Persistent_BSS_Mode            := Persistent_BSS_Mode;
      Save.Polling_Required               := Polling_Required;
      Save.Short_Descriptors              := Short_Descriptors;
      Save.Use_VADS_Size                  := Use_VADS_Size;
   end Save_Opt_Config_Switches;

   -----------------------------
   -- Set_Opt_Config_Switches --
   -----------------------------

   procedure Set_Opt_Config_Switches
     (Internal_Unit : Boolean;
      Main_Unit     : Boolean)
   is
   begin
      --  Case of internal unit

      if Internal_Unit then

         --  Set standard switches. Note we do NOT set Ada_Version_Explicit
         --  since the whole point of this is that it still properly indicates
         --  the configuration setting even in a run time unit.

         Ada_Version                 := Ada_Version_Runtime;
         Dynamic_Elaboration_Checks  := False;
         Extensions_Allowed          := True;
         External_Name_Exp_Casing    := As_Is;
         External_Name_Imp_Casing    := Lowercase;
         Optimize_Alignment          := 'O';
         Persistent_BSS_Mode         := False;
         Use_VADS_Size               := False;
         Optimize_Alignment_Local    := True;

         --  For an internal unit, assertions/debug pragmas are off unless this
         --  is the main unit and they were explicitly enabled. We also make
         --  sure we do not assume that values are necessarily valid.

         if Main_Unit then
            Assertions_Enabled       := Assertions_Enabled_Config;
            Assume_No_Invalid_Values := Assume_No_Invalid_Values_Config;
            Debug_Pragmas_Enabled    := Debug_Pragmas_Enabled_Config;
            Check_Policy_List        := Check_Policy_List_Config;
         else
            Assertions_Enabled       := False;
            Assume_No_Invalid_Values := False;
            Debug_Pragmas_Enabled    := False;
            Check_Policy_List        := Empty;
         end if;

      --  Case of non-internal unit

      else
         Ada_Version                 := Ada_Version_Config;
         Ada_Version_Explicit        := Ada_Version_Explicit_Config;
         Assertions_Enabled          := Assertions_Enabled_Config;
         Assume_No_Invalid_Values    := Assume_No_Invalid_Values_Config;
         Check_Policy_List           := Check_Policy_List_Config;
         Debug_Pragmas_Enabled       := Debug_Pragmas_Enabled_Config;
         Dynamic_Elaboration_Checks  := Dynamic_Elaboration_Checks_Config;
         Extensions_Allowed          := Extensions_Allowed_Config;
         External_Name_Exp_Casing    := External_Name_Exp_Casing_Config;
         External_Name_Imp_Casing    := External_Name_Imp_Casing_Config;
         Fast_Math                   := Fast_Math_Config;
         Init_Or_Norm_Scalars        := Init_Or_Norm_Scalars_Config;
         Initialize_Scalars          := Initialize_Scalars_Config;
         Optimize_Alignment          := Optimize_Alignment_Config;
         Optimize_Alignment_Local    := False;
         Persistent_BSS_Mode         := Persistent_BSS_Mode_Config;
         Use_VADS_Size               := Use_VADS_Size_Config;
      end if;

      Default_Pool                   := Default_Pool_Config;
      Exception_Locations_Suppressed := Exception_Locations_Suppressed_Config;
      Fast_Math                      := Fast_Math_Config;
      Optimize_Alignment             := Optimize_Alignment_Config;
      Polling_Required               := Polling_Required_Config;
      Short_Descriptors              := Short_Descriptors_Config;
   end Set_Opt_Config_Switches;

   ----------------
   -- SPARK_Mode --
   ----------------

   function SPARK_Mode return Boolean is
   begin
      --  When dropping the debug flag in favor of a compiler option,
      --  the option should implicitly set the SPARK_Version, so that this test
      --  becomes simply SPARK_Version > SPARK_None.

      return Debug.Debug_Flag_Dot_DD or else SPARK_Version > SPARK_None;
   end SPARK_Mode;

   ---------------
   -- Tree_Read --
   ---------------

   procedure Tree_Read is
      Tree_Version_String_Len         : Nat;
      Ada_Version_Config_Val          : Nat;
      Ada_Version_Explicit_Config_Val : Nat;
      Assertions_Enabled_Config_Val   : Nat;

   begin
      Tree_Read_Int  (Tree_ASIS_Version_Number);
      Tree_Read_Bool (Brief_Output);
      Tree_Read_Bool (GNAT_Mode);
      Tree_Read_Char (Identifier_Character_Set);
      Tree_Read_Int  (Maximum_File_Name_Length);
      Tree_Read_Data (Suppress_Options'Address,
                      (Suppress_Options'Size + SU - 1) / SU);
      Tree_Read_Bool (Verbose_Mode);
      Tree_Read_Data (Warning_Mode'Address,
                      (Warning_Mode'Size + SU - 1) / SU);
      Tree_Read_Int  (Ada_Version_Config_Val);
      Tree_Read_Int  (Ada_Version_Explicit_Config_Val);
      Tree_Read_Int  (Assertions_Enabled_Config_Val);
      Tree_Read_Bool (All_Errors_Mode);
      Tree_Read_Bool (Assertions_Enabled);
      Tree_Read_Int  (Int (Check_Policy_List));
      Tree_Read_Bool (Debug_Pragmas_Enabled);
      Tree_Read_Int  (Int (Default_Pool));
      Tree_Read_Bool (Enable_Overflow_Checks);
      Tree_Read_Bool (Full_List);

      Ada_Version_Config :=
        Ada_Version_Type'Val (Ada_Version_Config_Val);
      Ada_Version_Explicit_Config :=
        Ada_Version_Type'Val (Ada_Version_Explicit_Config_Val);
      Assertions_Enabled_Config :=
        Boolean'Val (Assertions_Enabled_Config_Val);

      --  Read version string: we have to get the length first

      Tree_Read_Int (Tree_Version_String_Len);

      declare
         Tmp : String (1 .. Integer (Tree_Version_String_Len));
      begin
         Tree_Read_Data
           (Tmp'Address, Tree_Version_String_Len);
         System.Strings.Free (Tree_Version_String);
         Free (Tree_Version_String);
         Tree_Version_String := new String'(Tmp);
      end;

      Tree_Read_Data (Distribution_Stub_Mode'Address,
                      (Distribution_Stub_Mode'Size + SU - 1) / Storage_Unit);
      Tree_Read_Bool (Inline_Active);
      Tree_Read_Bool (Inline_Processing_Required);
      Tree_Read_Bool (List_Units);
      Tree_Read_Bool (Configurable_Run_Time_Mode);
      Tree_Read_Data (Operating_Mode'Address,
                      (Operating_Mode'Size + SU - 1) / Storage_Unit);
      Tree_Read_Bool (Suppress_Checks);
      Tree_Read_Bool (Try_Semantics);
      Tree_Read_Data (Wide_Character_Encoding_Method'Address,
                      (Wide_Character_Encoding_Method'Size + SU - 1) / SU);
      Tree_Read_Bool (Upper_Half_Encoding);
      Tree_Read_Bool (Force_ALI_Tree_File);
   end Tree_Read;

   ----------------
   -- Tree_Write --
   ----------------

   procedure Tree_Write is
      Version_String : String := Gnat_Version_String;

   begin
      Tree_Write_Int  (ASIS_Version_Number);
      Tree_Write_Bool (Brief_Output);
      Tree_Write_Bool (GNAT_Mode);
      Tree_Write_Char (Identifier_Character_Set);
      Tree_Write_Int  (Maximum_File_Name_Length);
      Tree_Write_Data (Suppress_Options'Address,
                       (Suppress_Options'Size + SU - 1) / SU);
      Tree_Write_Bool (Verbose_Mode);
      Tree_Write_Data (Warning_Mode'Address,
                       (Warning_Mode'Size + SU - 1) / Storage_Unit);
      Tree_Write_Int  (Ada_Version_Type'Pos (Ada_Version_Config));
      Tree_Write_Int  (Ada_Version_Type'Pos (Ada_Version_Explicit_Config));
      Tree_Write_Int  (Boolean'Pos (Assertions_Enabled_Config));
      Tree_Write_Bool (All_Errors_Mode);
      Tree_Write_Bool (Assertions_Enabled);
      Tree_Write_Int  (Int (Check_Policy_List));
      Tree_Write_Bool (Debug_Pragmas_Enabled);
      Tree_Write_Int  (Int (Default_Pool));
      Tree_Write_Bool (Enable_Overflow_Checks);
      Tree_Write_Bool (Full_List);
      Tree_Write_Int  (Int (Version_String'Length));
      Tree_Write_Data (Version_String'Address, Version_String'Length);
      Tree_Write_Data (Distribution_Stub_Mode'Address,
                       (Distribution_Stub_Mode'Size + SU - 1) / SU);
      Tree_Write_Bool (Inline_Active);
      Tree_Write_Bool (Inline_Processing_Required);
      Tree_Write_Bool (List_Units);
      Tree_Write_Bool (Configurable_Run_Time_Mode);
      Tree_Write_Data (Operating_Mode'Address,
                       (Operating_Mode'Size + SU - 1) / SU);
      Tree_Write_Bool (Suppress_Checks);
      Tree_Write_Bool (Try_Semantics);
      Tree_Write_Data (Wide_Character_Encoding_Method'Address,
                       (Wide_Character_Encoding_Method'Size + SU - 1) / SU);
      Tree_Write_Bool (Upper_Half_Encoding);
      Tree_Write_Bool (Force_ALI_Tree_File);
   end Tree_Write;

end Opt;
