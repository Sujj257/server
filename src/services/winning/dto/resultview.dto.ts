import { IsNotEmpty, IsString } from 'class-validator';

export class WinningResultViewDto {
  @IsString()
  @IsNotEmpty()
  from_date: string;

  @IsString()
  @IsNotEmpty()
  to_date: string;

  @IsString()
  @IsNotEmpty()
  draw_id: string;
}
