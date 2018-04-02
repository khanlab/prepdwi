function writeShellsFromBval (in_bval_txt,out_shell_txt)

bval=importdata(in_bval_txt);
shells=findBvalShells(bval); 
dlmwrite(out_shell_txt,shells');

end