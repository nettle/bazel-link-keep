#!/bin/bash

echo "SECTIONS {"
echo "  .text : {"
echo "    KEEP(*($@ .text))"
echo "  }"
echo "}"
