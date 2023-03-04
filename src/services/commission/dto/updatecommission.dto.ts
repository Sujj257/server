import { IsDecimal, IsNotEmpty, IsInt } from 'class-validator';

export class UpdateCommissionDto {
  @IsInt()
  @IsNotEmpty()
  account_id: number;

  @IsDecimal()
  @IsNotEmpty()
  abc: number;

  @IsDecimal()
  @IsNotEmpty()
  abbcac: number;

  @IsDecimal()
  @IsNotEmpty()
  s_dear: number;

  @IsDecimal()
  @IsNotEmpty()
  s_box: number;
}
