import {
  IsNotEmpty,
  IsString,
  IsBoolean,
  IsInt,
  IsArray,
} from 'class-validator';

export class WinningExecuteDto {
  @IsInt()
  @IsNotEmpty()
  draw_id: number;

  @IsString()
  @IsNotEmpty()
  draw_date: string;

  @IsString()
  first: string;

  @IsString()
  second: string;

  @IsString()
  third: string;

  @IsString()
  forth: string;

  @IsString()
  fifth: string;

  @IsArray()
  sixth: Array<string>;

  @IsBoolean()
  hidden_update = false;
}
