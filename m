Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:37406 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeCNQSZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Mar 2018 12:18:25 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Stef Bon <stefbon@gmail.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
        <1520540650-7451-5-git-send-email-zohar@linux.vnet.ibm.com>
        <CANXojczCU3UC4xsPYzAYqFW3_WR9Z7QO_exd4dB6eyQR2STuUg@mail.gmail.com>
        <1521032461.3547.404.camel@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 11:17:33 -0500
In-Reply-To: <1521032461.3547.404.camel@linux.vnet.ibm.com> (Mimi Zohar's
        message of "Wed, 14 Mar 2018 09:01:01 -0400")
Message-ID: <877eqer5r6.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v3 4/4] fuse: define the filesystem as untrusted
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> On Wed, 2018-03-14 at 08:52 +0100, Stef Bon wrote:
>> I do not have any comments about the patches but a question.
>> I completely agree that the files can change without the VFS knowing
>> about it, but isn't that in general the case with filesystems with a
>> backend shared with others (network fs's?).
>
> Right, the problem is not limited to fuse, but needs to be addressed
> before unprivileged fuse mounts are upstreamed.
>
> Alban's response to this question:
> https://marc.info/?l=linux-kernel&m=151784020321045&w=2

Which goes to why it is a flag that get's set.

All of this just needs a follow-up patch to update every filesystem
that does not meet ima's requirements.

Mimi I believe you said that the requirement is that all file changes
can be detected through the final __fput of a file that calls
ima_file_free.

Eric
