#!/bin/bash -login

figlet "AGENDA:"
echo
echo "1. Compile source file \`count.c\` into an executable \`count.out\`."
echo "   This executable prints an ascending count at one second intervals,"
echo "      starting at zero."
echo "   It also reads in the first line from the file \`ckpt_status\`,"
echo "     and prints that line alongside the count."
echo "   (We'll update the content of \`ckpt_status\` along the way,"
echo "      just so we're double sure of what's going on and where we are.)"
echo "   Each step, we write current count and ckpt_status to \`count_status\`"
echo "      so, at the end, we can programatically check everything worked."
echo
read -p "Press enter to continue..."
echo
echo "2. Run \`./count.out\`, taking checkpoint snapshots every 10 seconds."
echo "   We'll use \`timeout\` to kill the run after 18 seconds."
echo "   So, we expect a checkpoint of the run at 10 seconds to be completed."
echo
read -p "Press enter to continue..."
echo
echo "3. Use the generated \`./dmtcp_restart_script.sh\` to continue the run"
echo "      where we left off!"
echo "   \`timeout\` will kill the run after 18 seconds."
echo "   Checkpoints continue to be taken every 10 seconds,"
echo "      so we expect to start at the 10 second checkpoint"
echo "      and leave behind a checkpoint from 20 seconds into the run."
echo
read -p "Press enter to continue..."
echo
echo "4. Again, use \`./dmtcp_restart_script.sh\` to continue the run"
echo "      where we left off!"
echo "   \`timeout\` will kill the run after 18 seconds."
echo "   We'll start at the 20 second checkpoint and"
echo "      expect to make it past the 30 second mark before we get toasted."
echo
read -p "Press enter to continue..."
echo
echo "5. Check the \`count_status\` file to make sure that we reached"
echo "     a \`ckpt_status\` of \"after second checkpoint\""
echo "     and a count of at least 30."
echo
read -p "Press enter to continue..."
echo

echo
figlet "LET'S ROLL!"
read -p "Press enter to continue..."

echo
echo ">>> COMPILING count.out"
read -p "Press enter to continue..."
make count.out

echo
echo ">>> SETTING ckpt_status TO \"before first checkpoint\""
read -p "Press enter to continue..."
echo "before first checkpoint" > "ckpt_status"

echo
echo ">>> LAUNCHING ./count.out"
echo ">>> RUN FOR 18 SECONDS AND CHECKPOINT EVERY 10 SECONDS"
read -p "Press enter to continue..."
timeout --kill-after=18 18 dmtcp_launch -i 10 ./count.out | tee count_status

echo
echo ">>> SETTING ckpt_status TO \"after first checkpoint\""
read -p "Press enter to continue..."
echo "after first checkpoint" > ckpt_status

echo
echo ">>> RESTARTING ./count.out AT FIRST CHECKPOINT"
echo ">>> RUN FOR 18 SECONDS AND CHECKPOINT EVERY 10 SECONDS"
read -p "Press enter to continue..."
timeout --kill-after=18 18 ./dmtcp_restart_script.sh | tee count_status

echo
echo ">>> SETTING ckpt_status TO \"after second checkpoint\""
read -p "Press enter to continue..."
echo "after second checkpoint" > ckpt_status

echo
echo ">>> RESTARTING ./count.out AT SECOND CHECKPOINT"
echo ">>> RUN FOR 18 SECONDS AND CHECKPOINT EVERY 10 SECONDS"
read -p "Press enter to continue..."
timeout --kill-after=18 18 ./dmtcp_restart_script.sh | tee count_status

echo
echo ">>> VERIFY count_status TO MAKE SURE WE REACHED"
echo ">>>    \"after second checkpoint\""
echo ">>>    AND A COUNT OF AT LEAST 30."
read -p "Press enter to continue..."

if grep -q "after second checkpoint" count_status && grep -q "30" count_status; then
  figlet "YAY, SUCCESS!"
  exit 0
else
  figlet "UH-OH, FAILURE!"
  exit 1
fi
