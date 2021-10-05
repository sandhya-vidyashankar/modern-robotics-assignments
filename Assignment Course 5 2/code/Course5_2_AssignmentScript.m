clc %clear screen
fprintf('Example 1: Collapsing Assembly');
bodyList1 =  [1, 2, 25, 35;
             2, 5, 66, 42];
contactList1 =  [1, 0,  0,  0, pi/2, 0.1;
                 1, 2, 60, 60,   pi, 0.5;
                 2, 0, 72,  0, pi/2, 0.5;
                 2, 0, 60,  0, pi/2, 0.5];
 isstable1 = CheckStability(bodyList1,contactList1);
 disp(isstable1);
 
 fprintf('Example 2: Stable assembly');
 bodyList2 = [1, 2,  25, 35;
             2, 10, 66, 42];
contactList2 =  [1, 0,  0,  0, pi/2,  0.5;
                 1, 2, 60, 60,   pi,  0.5;
                 2, 0, 72,  0, pi/2,  0.5;
                 2, 0, 60,  0, pi/2,  0.5];
 isstable2 = CheckStability(bodyList2,contactList2);
 disp(isstable2);
 
 fprintf('Example 3: Fig 12.27 - unstable(see results directory)')
 bodyList3 = [1, 5, 110, 70; 2, 5, 260, 130; 3, 5, 410, 70];
 mu3 = 0.3;
 contactList3 = [1,1, 1, 1, 3, 3, 3, 3; 0, 0, 2, 2, 2, 2, 0, 0; 0, 80, 160, 180, 360, 340, 440, 520; 0, 0, 160, 100, 160, 100, 0, 0; pi/2, pi/2, -2.81993, -2.81993, -0.32166, -0.32166, pi/2, pi/2; mu3, mu3, mu3, mu3, mu3, mu3, mu3, mu3].';
 isstable3 = CheckStability(bodyList3, contactList3);
 disp(isstable3);
 
  fprintf('Example 4: Fig 12.27 - stable (see results directory)')
  bodyList4 = [1, 5, 110, 70; 2, 5, 260, 130; 3, 5, 410, 70];
  mu4 = 0.5;
  contactList4 = [1,1, 1, 1, 3, 3, 3, 3; 0, 0, 2, 2, 2, 2, 0, 0; 0, 80, 160, 180, 360, 340, 440, 520; 0, 0, 160, 100, 160, 100, 0, 0; pi/2, pi/2, -2.81993, -2.81993, -0.32166, -0.32166, pi/2, pi/2; mu4, mu4, mu4, mu4, mu4, mu4, mu4, mu4].';
  isstable4 = CheckStability(bodyList4, contactList4);
  disp(isstable4);