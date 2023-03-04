import { IsNotEmpty, IsString, IsInt } from 'class-validator';

export class WinningPrizeUpdateDto {
  @IsString()
  @IsNotEmpty()
  account_id: string;

  @IsString()
  @IsNotEmpty()
  updated_by: string;

  @IsInt()
  @IsNotEmpty()
  dear_1st_prize: number;

  @IsInt()
  @IsNotEmpty()
  dear_2st_prize: number;

  @IsInt()
  @IsNotEmpty()
  dear_3st_prize: number;

  @IsInt()
  @IsNotEmpty()
  dear_4st_prize: number;

  @IsInt()
  @IsNotEmpty()
  dear_5st_prize: number;

  @IsInt()
  @IsNotEmpty()
  dear_6st_prize: number;

  @IsInt()
  @IsNotEmpty()
  abc_1st_prize: number;

  @IsInt()
  @IsNotEmpty()
  abbcac_1st_prize: number;

  @IsInt()
  @IsNotEmpty()
  box_same_1st_prize: number;

  @IsInt()
  @IsNotEmpty()
  box_both_1st_prize: number;

  @IsInt()
  @IsNotEmpty()
  box_both_2st_prize: number;

  @IsInt()
  @IsNotEmpty()
  box_shuffle_1st_prize: number;

  @IsInt()
  @IsNotEmpty()
  box_shuffle_2st_prize: number;
}
