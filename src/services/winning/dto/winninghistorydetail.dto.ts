import { IsNotEmpty, IsString } from 'class-validator';

export class WinningDetailViewDto {
  @IsString()
  @IsNotEmpty()
  account_id: string;

  @IsString()
  @IsNotEmpty()
  p_date: string;

  @IsString()
  @IsNotEmpty()
  draw_id: string;

  @IsString()
  @IsNotEmpty()
  ticket_type: string;

  @IsString()
  @IsNotEmpty()
  number: string;
}
