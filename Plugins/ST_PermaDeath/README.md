# Pokemon Permadeath Plugin
Developed and tested for Pokemon Essentials v21.1!

See the repro's main README for instructions.
A message is shown to the player after the battle when one or more of their Pokemon have died, displaying the (nick)name and level of the Pokemon as well as coloring the name according to its gender (green for genderless).<br>
One Pokemon died:<br>
<img width="639" height="124" alt="Screenshot 2025-10-10 194123" src="https://github.com/user-attachments/assets/1bf19cf4-46a1-460a-bd56-1efeaa939c90" /><br>
Multiple Pokemon died:<br>
<img width="756" height="153" alt="Screenshot 2025-10-10 194042" src="https://github.com/user-attachments/assets/3c6cf541-272f-493c-8530-bc3505de6ec0" />
<img width="463" height="145" alt="Screenshot 2025-10-10 194200" src="https://github.com/user-attachments/assets/15a76fc0-ef0f-4123-9c89-1497ac779abc" /><br><br>
If you also download and install my Utilities plugin, you will get a fancier text display where it states specifically how many have died in words:<br>
<img width="669" height="132" alt="Screenshot 2025-10-10 194106" src="https://github.com/user-attachments/assets/ebf4e0fd-be55-4105-9a29-311694f02018" />
<br><br>
If your game uses the version of the mechanics where Pokemon can faint from poison in the overworld, this plugin will kill them instead.<br>
<img width="759" height="568" alt="Screenshot 2025-10-10 201133" src="https://github.com/user-attachments/assets/22694b08-be77-48e2-af0c-e26fe68b729d" />
<br><br>
There's an attempt to handle situations where all your Pokemon are dead and the player could get softlocked in a loop of passing out every couple steps, however ultimately you should ensure that such a situation doesn't happen.
