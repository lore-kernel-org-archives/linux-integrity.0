Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:40684 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbeCNHwE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Mar 2018 03:52:04 -0400
MIME-Version: 1.0
In-Reply-To: <1520540650-7451-5-git-send-email-zohar@linux.vnet.ibm.com>
References: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com> <1520540650-7451-5-git-send-email-zohar@linux.vnet.ibm.com>
From: Stef Bon <stefbon@gmail.com>
Date: Wed, 14 Mar 2018 08:52:01 +0100
Message-ID: <CANXojczCU3UC4xsPYzAYqFW3_WR9Z7QO_exd4dB6eyQR2STuUg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] fuse: define the filesystem as untrusted
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

I do not have any comments about the patches but a question.
I completely agree that the files can change without the VFS knowing
about it, but isn't that in general the case with filesystems with a
backend shared with others (network fs's?).

Stef
