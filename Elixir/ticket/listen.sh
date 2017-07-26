#!/bin/bash
pgrep beam.smp &> /dev/null
if [ $? -gt 0 ]
then
echo "not running" >> /home/wwwroot/ticket.darkjs.com/Elixir/ticket/log/mix.log
cd /home/wwwroot/ticket.darkjs.com/Elixir/ticket/
nohup mix run --no-halt &
else
echo "mix running" >> /home/wwwroot/ticket.darkjs.com/Elixir/ticket/log/mix.log
fi
