function matnew=OnDeleteMatrix(mat,rowindex,colindex)
%----------------------------------%
%This matlab file aims at to delete some rows and collums from a matrix.
%mat is the input matrix
%rowindex indicates which rows need to be deleted
%colindex indicates which columns need to be deleted
%----------------------------------%

matnew=mat;
matnew(rowindex,:)=[];
matnew(:,colindex)=[];