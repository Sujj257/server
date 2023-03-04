import { IsNotEmpty, IsString, IsBoolean, IsInt } from 'class-validator';

export class WinningCommissionDto {
  @IsString()
  @IsNotEmpty()
  account_id: string;

  @IsString()
  @IsNotEmpty()
  updated_by: string;

  @IsInt()
  @IsNotEmpty()
  dear_1st_prize_commission: number;

  @IsInt()
  @IsNotEmpty()
  dear_2st_prize_commission: number;

  @IsInt()
  @IsNotEmpty()
  dear_3st_prize_commission: number;

  @IsInt()
  @IsNotEmpty()
  dear_4st_prize_commission: number;

  @IsInt()
  @IsNotEmpty()
  dear_5st_prize_commission: number;

  @IsInt()
  @IsNotEmpty()
  dear_6st_prize_commission: number;

  @IsInt()
  @IsNotEmpty()
  abc_1st_prize_commission: number;

  @IsInt()
  @IsNotEmpty()
  abbcac_1st_prize_commission: number;

  @IsInt()
  @IsNotEmpty()
  box_same_1st_prize_commission: number;

  @IsInt()
  @IsNotEmpty()
  box_both_1st_prize_commission: number;

  @IsInt()
  @IsNotEmpty()
  box_both_2st_prize_commission: number;

  @IsInt()
  @IsNotEmpty()
  box_shuffle_1st_prize_commission: number;

  @IsInt()
  @IsNotEmpty()
  box_shuffle_2st_prize_commission: number;

  @IsBoolean()
  block_from_draw = false;
}
