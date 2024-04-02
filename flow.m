function flow()
    clinton = readtable('clinton_elevation.csv');
    % size(clinton.Z)
    elevation = [clinton.X - min(clinton.X), clinton.Y - min(clinton.Y), clinton.Z];
    % A = transpose(clinton.X);
    % B = transpose(clinton.Y);
    % C = transpose(clinton.Z);
    A = 1:10;
    B = 1:10;
    C = [1:10; 1:10; 1:10;];
    size(A)
    size(B)
    size(C)
    DEM = GRIDobj(A,B,C);

    https://portal.opentopography.org/usgsDataset?dsid=NY_FEMAR2_Central_3_2018
