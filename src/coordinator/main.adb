with Ada.Text_IO; use Ada.Text_IO;
with Ada.Characters.Latin_1;
with System.OS_Lib;
with Robot_State; use Robot_State;

procedure Main is
   Current_State : Transaction_State := (Quick, Dry_Run, Complete);
   Input_Char    : Character;
   Available     : Boolean;
   Command_Str   : String(1..256);
   Len           : Natural;
   Args          : System.OS_Lib.Argument_List(1..0); -- Placeholder for spawn
   Success       : Boolean;

   procedure Clear_Screen is
   begin
      Put (Ada.Characters.Latin_1.ESC & "[2J");
      Put (Ada.Characters.Latin_1.ESC & "[H");
   end Clear_Screen;

   procedure Render_Menu is
   begin
      Clear_Screen;
      Put_Line ("========================================");
      Put_Line ("   R O B O T   C O O R D I N A T O R    ");
      Put_Line ("        (Ada/SPARK Verified)            ");
      Put_Line ("========================================");
      Put_Line ("Current Permutation:");
      Put_Line ("  [1] Audit Level: " & Current_State.Audit'Image);
      Put_Line ("  [2] Repair Mode: " & Current_State.Repair'Image);
      Put_Line ("  [3] Scope:       " & Current_State.Scope'Image);
      Put_Line ("----------------------------------------");
      
      if Is_Safe (Current_State) then
         Put_Line ("Status: [SAFE] Ready to Transact.");
      else
         Put_Line ("Status: [UNSAFE] Interlock Engaged. Cannot Execute.");
      end if;

      New_Line;
      Put_Line ("Controls:");
      Put_Line ("  [1/2/3] Cycle Options");
      Put_Line ("  [E]xecute Transaction");
      Put_Line ("  [Q]uit");
      Put ("> ");
   end Render_Menu;

begin
   loop
      Render_Menu;
      
      Get_Immediate (Input_Char);
      
      case Input_Char is
         when 'q' | 'Q' => exit;
         
         when '1' =>
            if Current_State.Audit = Transaction_State.Audit_Level'Last then
               Current_State.Audit := Transaction_State.Audit_Level'First;
            else
               Current_State.Audit := Transaction_State.Audit_Level'Succ(Current_State.Audit);
            end if;

         when '2' =>
            if Current_State.Repair = Transaction_State.Repair_Mode'Last then
               Current_State.Repair := Transaction_State.Repair_Mode'First;
            else
               Current_State.Repair := Transaction_State.Repair_Mode'Succ(Current_State.Repair);
            end if;

         when '3' =>
            if Current_State.Scope = Transaction_State.Target_Scope'Last then
               Current_State.Scope := Transaction_State.Target_Scope'First;
            else
               Current_State.Scope := Transaction_State.Target_Scope'Succ(Current_State.Scope);
            end if;

         when 'e' | 'E' =>
            if Is_Safe (Current_State) then
               Put_Line ("");
               Put_Line (">>> Interlock Released. Transacting...");
               -- In a real scenario, we Spawn the process here.
               -- For now, we output the Intent String.
               Put_Line (Generate_Command(Current_State));
               delay 2.0; 
            else
               Put_Line ("");
               Put_Line ("!!! SAFETY VIOLATION: Transaction Rejected.");
               delay 1.0;
            end if;

         when others => null;
      end case;
   end loop;
   
   Clear_Screen;
   Put_Line ("Coordinator Terminated.");
end Main;
