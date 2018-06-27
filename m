Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36147 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbeF0GKA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jun 2018 02:10:00 -0400
Received: by mail-oi0-f66.google.com with SMTP id r16-v6so281907oie.3
        for <linux-integrity@vger.kernel.org>; Tue, 26 Jun 2018 23:10:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKNRAJW-7BUCRwiUneW+pDU4k4jXY6S5XNxAJCmQnE9AkP2ooA@mail.gmail.com>
References: <20180608071146.110567-1-louiscollard@chromium.org>
 <20180618180943.GD20697@linux.intel.com> <CAKNRAJW-7BUCRwiUneW+pDU4k4jXY6S5XNxAJCmQnE9AkP2ooA@mail.gmail.com>
From: Louis Collard <louiscollard@chromium.org>
Date: Wed, 27 Jun 2018 14:09:59 +0800
Message-ID: <CAKNRAJU98YMzATxHR9grC7sdXxmv-cscrSZJOqKk+Laf1nV=Mg@mail.gmail.com>
Subject: Re: [PATCH] tpm: Allow tpm_tis drivers to set hwrng quality.
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi sorry I'm not sure I understand; I based the change on linux-next
master, let me know if I should be using something else. The change is
not dependent on https://patchwork.kernel.org/patch/10453893/

On Wed, Jun 27, 2018 at 1:28 PM, Louis Collard
<louiscollard@chromium.org> wrote:
> Hi sorry I'm not sure I understand; I based the change on linux-next master,
> let me know if I should be using something else. The change is not dependent
> on https://patchwork.kernel.org/patch/10453893/
>
> On Tue, Jun 19, 2018 at 2:09 AM, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
>>
>> On Fri, Jun 08, 2018 at 03:11:46PM +0800, Louis Collard wrote:
>> > Adds plumbing required for drivers based on tpm_tis to set hwrng
>> > quality.
>> >
>> > Signed-off-by: Louis Collard <louiscollard@chromium.org>
>>
>> NAK because this not connected to the current GIT tree (should probably
>> make a patch set?).
>>
>> /Jarkko
>
>
