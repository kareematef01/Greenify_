import { NgClass, NgFor } from '@angular/common';
import { Component, ElementRef, NgModule } from '@angular/core';
import { GeminiService } from '../../services/gemini/gemini.service';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-chat-bot',
  standalone: true,
  imports: [NgFor, NgClass, FormsModule],
  templateUrl: './chat-bot.component.html',
  styleUrl: './chat-bot.component.css'
})
export class ChatBotComponent {

  isChatLoading: boolean = false
  messages: { text: string, type: 'sent' | 'received', isLoading?: boolean }[] = [
    { text: 'Hi there! How can I help you today?😊', type: 'received' }
  ];
  
  newMessage: string = '';
  chatResponse: string = ''
  cleanedText:string = ''
  chatBox!: ElementRef;

  constructor(private aiService: GeminiService) { }


  generateAIResponse() {


    this.isChatLoading = true
    if (this.newMessage.trim()) {
      this.messages.push({ text: this.newMessage, type: 'sent' });
    }
    this.aiService.generateText(this.newMessage).subscribe(
      (response) => {

        this.newMessage = '';
        this.chatResponse = response?.candidates?.[0]?.content?.parts?.[0]?.text || 'No response';
        this.cleanedText=this.removeMarkdown(this.chatResponse);
        setTimeout(() => {
          this.messages.push({ text: this.cleanedText, type: 'received' });
          this.scrollToBottom();
        }, 1000);

        this.scrollToBottom();
        this.isChatLoading = false
      },
      (error) => {
        this.messages.push({ text: ' error please try again ', type: 'received' });
        this.scrollToBottom();
        this.isChatLoading = true

      }
    );
    this.newMessage = '';
  }


  // sendMessage() {
  //   if (this.newMessage.trim()) {
  //     this.messages.push({ text: this.newMessage, type: 'sent' });
  //     this.newMessage = '';

  //     setTimeout(() => {
  //       this.messages.push({ text: 'تم استلام رسالتك!', type: 'received' });
  //       this.scrollToBottom();
  //     }, 1000);

  //     this.scrollToBottom();
  //   }
  // }

  scrollToBottom() {
    setTimeout(() => {
      if (this.chatBox) {
        this.chatBox.nativeElement.scrollTop = this.chatBox.nativeElement.scrollHeight;
      }
    }, 100);
  }

  removeMarkdown(text: string): string {
    return text
    .replace(/\*/g, '')          // إزالة كل النجوم
    .replace(/__/g, '')          // إزالة علامات التسطير المزدوج
    .replace(/_/g, '')           // إزالة التسطير الفردي
    .replace(/`+/g, '')          // إزالة علامات الكود
    .replace(/#+\s?/g, '')       // إزالة العناوين (#)
    .replace(/!\[.*?\]\(.*?\)/g, '')  // إزالة الصور ![alt](url)
    .replace(/\[.*?\]\(.*?\)/g, '')   // إزالة الروابط [text](url)
    .replace(/>\s?/g, '')        // إزالة علامات الاقتباس
    .replace(/-{3,}/g, '')       // إزالة فواصل الخطوط ---
    .replace(/\n{2,}/g, '\n')    // تقليل الفراغات
    .trim();
  }



}
