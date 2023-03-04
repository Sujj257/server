import { IsNotEmpty, IsBoolean } from 'class-validator';

export class DownlineDto {
  @IsBoolean()
  @IsNotEmpty()
  show_my_acc = false;
}
