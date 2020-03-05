function aes-enc {
  local infile="$1"
  local outfile="$infile.aes-encrypted"

  echo Encrypting $infile
  if openssl aes-256-cbc -a -salt -in $infile -out $outfile; then
    echo Success. New encrypted file at $outfile
  else
    echo File not encrypted >&2
    return 1
  fi
}

function aes-dec {
  local infile="$1"
  local outfile=$(mktemp XXXXXXXX)
  local option="$2"

  echo Attempting to decrypt $infile >&2
  if openssl aes-256-cbc -d -a -salt -in $infile -out $outfile; then
    if [ "$option" = "export" ]; then
      export $(grep -v '^#' $outfile | xargs -0)
    else
      cat $outfile
    fi
    rm $outfile
  else
    rm $outfile
    echo File not decrypted >&2
    return 1
  fi
}

alias dec-profile="aes-dec ~/.profile.aes-encrypted export"
